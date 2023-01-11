import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/failures.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepo{
  Future<Either<Failure,  NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure,  NumberTrivia>> getRandomNumberTrivia();
}