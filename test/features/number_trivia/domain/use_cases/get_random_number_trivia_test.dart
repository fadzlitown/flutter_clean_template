import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/usecase/usecase.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo{}

// @GenerateMocks([NumberTriviaRepo])
void main(){
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepo mockRepo;
  late NumberTrivia tNumTrivia;

  //will run first before test
  setUp((){
    mockRepo = MockNumberTriviaRepo();
    usecase = GetRandomNumberTrivia(mockRepo);
    tNumTrivia = NumberTrivia(text: 'test', number: 1);

  });


  test('should get random number from repo', () async {
    //arrange
    when(mockRepo.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumTrivia));  //for positive test

    //act
    final result = await usecase(NoParams()); //no error bcs usecase is dynamic

    //assert
    expect(result, equals(Right(tNumTrivia)));
    //mockito check
    verify(mockRepo.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockRepo);
  });
}
