import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/core/util/input_conversion.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';

import '../../../core/usecase/usecase.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_state_event.dart';

part 'number_trivia_state_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaStateBloc
    extends Bloc<NumberTriviaStateEvent, NumberTriviaStateState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConversion converter;

  NumberTriviaStateBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.converter})
      : super(NumberTriviaStateInitial()) {

    on<GetNumberConcreteTrivia>((event, emit) {
      final inputEither = converter.stringToInteger(event.numberStr);
      inputEither.fold((l) {  //sync code
        emit(Error(INVALID_INPUT_FAILURE_MESSAGE));
      }, (integer) {
        emit(Loading());
        callApi(integer); //this method handles async code
      });
    });

    on<GetRandomNumberConcreteTrivia>((event, emit) async {
      emit(Loading());
      // from BLOC (PRESENTATION) --> USECASE (DOMAIN) in getRandomNumberTrivia
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      // _isLoadedOrError(failureOrTrivia!);
      failureOrTrivia?.fold((failure) {
        emit(Error(_mapFailureToMessage(failure)));
      }, (trivia) {
        emit(Loaded(trivia));
      });
    });
  }

  //Todo 2. Need to update the state. So need to update the abstract state NumberTriviaStateState
  Stream<NumberTriviaStateState> _isLoadedOrError(
      Either<Failure, NumberTrivia> failureOrTrivia) async* {
     failureOrTrivia.fold((failure)  {
      emit(Error(_mapFailureToMessage(failure)));
    }, (numberTrivia) {
      emit(Loaded(numberTrivia));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  Future<void> callApi(int integer) async {
    // from BLOC (PRESENTATION) --> USECASE (DOMAIN) in getConcreteNumberTrivia
    final failureOrTrivia = await getConcreteNumberTrivia(Params(number: integer));
    failureOrTrivia?.fold((failure)  {
      emit(Error(_mapFailureToMessage(failure)));
    }, (numberTrivia) {
      emit(Loaded(numberTrivia));
    });
  }
}
