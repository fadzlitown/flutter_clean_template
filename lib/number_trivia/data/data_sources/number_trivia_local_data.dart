
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

  Future<void>? cacheNumberTrivia(NumberTrivia triviaCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

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


