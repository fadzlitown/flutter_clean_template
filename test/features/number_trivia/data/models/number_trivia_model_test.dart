

import 'dart:convert';

import '../../../../fixtures/fixture_reader.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

//todo TDD NumberTriviaModel Data Model in data/models
void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'adsasdsad');

  test('should be a subclass of NumberTrivia entity',(){
    expect(tNumberTriviaModel, isA<NumberTrivia>());  //isA = Returns a matcher that matches objects with type
  });
  
  group('fromJson', () { 
    test('should return a value model when the JSON num is an integer',(){
     //arrange
      final Map<String,dynamic> jsonMap = json.decode(fixture('trivia.json')); //from json file convert to map

      //act
      final result = NumberTriviaModel.fromJson(jsonMap);

      //assert
      expect(result, tNumberTriviaModel);

    });
  });

  group('toJson', () {
    test('should return a JSON Map when the JSON num is an integer',(){

      //act
      final result = tNumberTriviaModel.toJson();

      final expectedMap = {
        "text": "adsasdsad",
        "number": 1,
      };

      //assert
      expect(result, expectedMap);

    });
  });
}