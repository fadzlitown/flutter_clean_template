import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_remote_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';

import '../../../core/platform/network_info.dart';
import '../../../core/error/server_exceptions.dart';
import '../data_sources/number_trivia_local_data.dart';
import '../models/number_trivia_model.dart';

//todo typedef means user-defined function/data interfaces. So that means you can define your own data types and functions
// typedef return ?? + method name .. To allowing any function accepting this func as argument
typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

// todo -> RepoImpl required to link into Repo in Domain layer
// create Repository implementation CONTRACT in Data layer. Model <--> RepoImpl
class NumberTriviaRepoImpl implements NumberTriviaRepo{

  NumberTriviaRemoteDataSource remoteData;
  NumberTriviaLocalDataSource localData;
  NetworkInfo networkInfo;

  NumberTriviaRepoImpl({required this.remoteData, required this.localData, required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(() {
      return remoteData.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteData.getRandomNumberTrivia();
    });
  }

  // shared _getTrivia method with get concrete & random
  // Check online & offline for both remote & local data
  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localData.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localData.getLastNumberTrivia()!;
        return Right(localTrivia);  //todo each of this result need to a unit test on test folder
      } on CacheExceptions {
        return Left(CacheFailure());
      }
    }
  }
}

