import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';

///todo -> 2. Create abstract Repo. what's the params accepting & returning?
abstract class NumberTriviaRepo{
  Future<Either<Failure,  NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure,  NumberTrivia>> getRandomNumberTrivia();
}