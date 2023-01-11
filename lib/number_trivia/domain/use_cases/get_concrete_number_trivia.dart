import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/failures.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepo repo;

  GetConcreteNumberTrivia(this.repo);

  //what we need to return
  Future<Either<Failure, NumberTrivia>> execute({
    required int number
  }) async {
    return await repo.getConcreteNumberTrivia(number);
  }
}