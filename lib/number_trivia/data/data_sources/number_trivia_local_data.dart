
import 'dart:convert';

import 'package:flutter_clean_arch_template/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/server_exceptions.dart';
import '../../domain/entities/number_trivia.dart';

//always cache from the latest remote data
// store the local data source using shared pref / cache
abstract class NumberTriviaLocalDataSource {

  // Get the cached NumberTriviaModel which was gotten the last time user connected to internet
  // Throws CacheException if no cached data is present
  Future<NumberTriviaModel>? getLastNumberTrivia();

  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    // TODO: need to convert to json
    final jsonStr = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if(jsonStr!=null){
      final value = NumberTriviaModel.fromJson(json.decode(jsonStr));
      return Future.value(value);
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaCache) {
    //todo Future<void> still need to return the void setter!!
    return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(triviaCache.toJson()));
  }




}


// class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
//   final SharedPreferences sharedPreferences;
//
//   NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
//
//   @override
//   Future<NumberTriviaModel>? getLastNumberTrivia() {
//     final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
//     if (jsonString != null) {
//       return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheExceptions();
//     }
//   }
//
//   @override
//   Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache) {
//     return sharedPreferences.setString(
//         CACHED_NUMBER_TRIVIA, json.encode(triviaToCache.toJson()));
//   }
// }


