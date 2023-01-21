import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/core/usecase/usecase.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';

///todo -> 3. For first use case, what we need to do?
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepo repo;

  //todo call the API
  //api.com/12
  //api.com/random
  GetConcreteNumberTrivia(this.repo);

  // Future<Either<Failure, NumberTrivia>> call({
  //   required int number
  // }) async {
  //   return await repo.getConcreteNumberTrivia(number);
  // }

  //what we need to return, exposed to call method for user uses/ enforced by abstract class.
  //todo --> usecase should always use call method !
  @override
  Future<Either<Failure, NumberTrivia>?> call(Params params) async {
    return await repo.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable{
  final int number;
  Params({required this.number});
  @override
  List<Object?> get props => [number];
}