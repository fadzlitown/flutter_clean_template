part of 'number_trivia_state_bloc.dart';

abstract class NumberTriviaStateEvent extends Equatable {
  NumberTriviaStateEvent();

  @override
  List<Object> get props => [];
}

class GetNumberConcreteTrivia extends NumberTriviaStateEvent{
  final String numberStr;
  GetNumberConcreteTrivia(this.numberStr);

  //todo: 1. Cannot use bcs it againts SINGLE RESPONSIBALITY!!, EVENT SHOULD NOT BE HANDLING VALUE CONVERSION / UI LOGIC
  //consider to put in CORE / UTIL folder to handle conversion
  //int get number => int.parse(numberStr);
}

//todo: 2. Add another RandomNumber fun
class GetRandomNumberConcreteTrivia extends NumberTriviaStateEvent{}

