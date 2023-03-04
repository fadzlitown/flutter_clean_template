//todo: 1 - DI Create this file & 2. Call the main here & get instance of GetIt

import 'package:flutter_clean_arch_template/core/platform/network_info.dart';
import 'package:flutter_clean_arch_template/core/util/input_conversion.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_local_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_remote_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/repositories/number_trivia_repo_impl.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/presentation/bloc/number_trivia_state_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia
  //Bloc
  //todo: 1 Presentation (Bloc) - registerFactory ALWAYS INSTANTIATE A NEW INSTANCE, for every call. (Cannot use singleton due to UI state / bloc always need to be updated on stream)
  injector.registerFactory(() =>
      NumberTriviaStateBloc(getConcreteNumberTrivia: injector(),    //injector() is a call method, it will looking all the registered class types
          getRandomNumberTrivia: injector(),
          converter: injector()));

  //todo: 2 Use cases (Domain) - registerFactory ONLY CREATED ONCE, REFER TO THE SAME INSTANCE WHEN FIRST LAUNCH!. No need to close the stream to be handle etc.
  injector.registerLazySingleton(() => GetConcreteNumberTrivia(injector()));
  injector.registerLazySingleton(() => GetRandomNumberTrivia(injector()));

  //todo 3 -  Repository Impl (DATA) - NumberTriviaRepoImpl implement NumberTriviaRepo
  injector.registerLazySingleton<NumberTriviaRepo>(() => NumberTriviaRepoImpl(remoteData: injector(), localData: injector(), networkInfo: injector()));

  //todo: 4 - Data Sources (Local & Remote)
  // NumberTriviaRemoteDataSourceImpl & NumberTriviaLocalDataSourceImpl (Data)
  injector.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(injector()));
  injector.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(injector()));

  // todo: 5 - Core folder for UTIL - InputConversion & NetworkInfoImpl
  injector.registerLazySingleton(() => InputConversion());
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));   //todo any class that extended to abstract required <NetworkInfo>

  // todo: 5 - External 3rd party packages (SP, http & internet checker) - SharedPreferences getInstance has Future, then used AWAIT & ASYNC
  final sharedPreferences = await SharedPreferences.getInstance();
  injector.registerLazySingleton(() => sharedPreferences);
  injector.registerLazySingleton(() => http.Client());  //API call
  injector.registerLazySingleton(()=> InternetConnectionChecker());   //networkInfo
}
