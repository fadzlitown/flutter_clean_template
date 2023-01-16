import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/usecase/usecase.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo{}

void main(){
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepo mockRepo;

  //will run first before test
  setUp((){
    mockRepo = MockNumberTriviaRepo();
    usecase = GetRandomNumberTrivia(mockRepo);
  });

  var tNumTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get random number from repo', () async {
    //arrange
    when(() => mockRepo.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumTrivia));  //for positive test

    //act
    final result = await usecase(NoParams()); //no error bcs usecase is dynamic

    //assert
    expect(result, Right(tNumTrivia));
    //mockito check
    verify(() => mockRepo.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockRepo);
  });
}
