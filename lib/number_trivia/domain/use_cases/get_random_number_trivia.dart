import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/core/usecase/usecase.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';

import '../repositories/number_trivia_repo.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepo repo;
  GetRandomNumberTrivia(this.repo);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repo.getRandomNumberTrivia();
  }
}