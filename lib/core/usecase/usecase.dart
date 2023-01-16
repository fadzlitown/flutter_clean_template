
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params>{
  //Type is a return type
  //Params is param what we want to pass/ todo stg

  //can use Params like this
  // Future<Either<Failure, Type>> call(Params params){
  //   log(params.hashCode);
  //   return null;
  // }
  Future<Either<Failure, Type>> call(Params params);

}

//todo 4 --> move it in common usecase, so that every layer/component can read it
class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}