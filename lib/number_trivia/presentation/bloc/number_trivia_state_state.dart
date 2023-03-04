part of 'number_trivia_state_bloc.dart';

abstract class NumberTriviaStateState extends Equatable {
  const NumberTriviaStateState();
  @override
  List<Object> get props => [];
}

class NumberTriviaStateInitial extends NumberTriviaStateState {}

class Empty extends NumberTriviaStateState {}

class Loading extends NumberTriviaStateState {}

class Loaded extends NumberTriviaStateState {
  NumberTrivia trivia;

  Loaded(this.trivia);
}

class Error extends NumberTriviaStateState {
  String message;

  Error(this.message);
}


