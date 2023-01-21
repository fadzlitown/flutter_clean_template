import 'dart:convert';

import 'package:flutter_clean_arch_template/core/error/server_exceptions.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/data_sources/number_trivia_local_data.dart';
import 'package:flutter_clean_arch_template/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main(){
  //need to hold instances
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json')));

    test('should return NumberTrivia from SP when there is one in the cache', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture('trivia_cache.json'));
      //act
      final result = await dataSource.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, tNumberTriviaModel);
    });


    test('should throw cacheException when no cache value', () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getLastNumberTrivia;  //exception return w/o future !! then remove await
      //assert
      // expect(call, throwsA(const TypeMatcher<CacheExceptions>()));
      expect(() => call(), throwsA(const TypeMatcher<CacheExceptions>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test trivia', number: 1);

    test('should call SP to cache the data', () async {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      //act
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      //assert
      final expectedJson = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA,expectedJson));
    });
  });
}