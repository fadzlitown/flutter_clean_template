import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/error/failures.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_remote_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';

import '../../../core/platform/network_info.dart';
import '../data_sources/number_trivia_local_data.dart';

// todo -> RepoImpl required to link into Repo in Domain layer
// create Repository implementation CONTRACT in Data layer. Model <--> RepoImpl
class NumberTriviaRepoImpl implements NumberTriviaRepo{

  NumberTriviaRemoteDataSource remoteData;
  NumberTriviaLocalDataSource localData;
  NetworkInfo networkInfo;

  NumberTriviaRepoImpl(this.remoteData, this.localData, this.networkInfo);

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

}