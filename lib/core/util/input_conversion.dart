import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConversion{
  Either<Failure,int> stringToInteger(String val){
    try{
      final integer = int.parse(val);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}