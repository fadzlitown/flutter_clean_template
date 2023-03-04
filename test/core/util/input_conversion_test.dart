import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch_template/core/util/input_conversion.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late InputConversion converter;

  setUp(() {
    converter = InputConversion();
  });


  group('stringToInteger',(){
    test('should return int when the string represent an int',(){
     //arrange
      final str = '123';
     //act
      final result = converter.stringToInteger(str);
     //assert = ensure the result will return 123
      expect(result,const Right(123));

    });

    test('should return a failure when the string is not an integer', (){
      //arrange
      final str = 'abc';
      //act
      final result =converter.stringToInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when the string is a negative integer', (){
      //arrange
      final str = '-1';
      //act
      final result =converter.stringToInteger(str);
      //assert
      expect(result,  Left(InvalidInputFailure()));
    });
  });
}

