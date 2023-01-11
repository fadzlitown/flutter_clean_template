import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/repositories/number_trivia_repo.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepo extends Mock implements NumberTriviaRepo{}

void main(){
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepo mockRepo;

  //will run first before test
  setUp((){
    mockRepo = MockNumberTriviaRepo();
    usecase = GetConcreteNumberTrivia(mockRepo);
  });
  
  const tNum = 1;
  var tNumTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get trivia for the number from repo', () async {
    //arrange
    when(() => mockRepo.getConcreteNumberTrivia(any()))
        .thenAnswer((_) async => Right(tNumTrivia));  //for positive test

    //act
    final result = await usecase.execute(number: tNum);

    //assert
    expect(result, Right(tNumTrivia));
    //mockito check
    verify(() => mockRepo.getConcreteNumberTrivia(tNum));
    verifyNoMoreInteractions(mockRepo);
  });
}
