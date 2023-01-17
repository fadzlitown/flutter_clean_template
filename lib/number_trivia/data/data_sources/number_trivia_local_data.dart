
import 'package:flutter_clean_arch_template/number_trivia/data/models/number_trivia_model.dart';

import '../../domain/entities/number_trivia.dart';

//always cache from the latest remote data
// store the local data source using shared pref / cache
abstract class NumberTriviaLocalDataSource {

  // Get the cached NumberTriviaModel which was gotten the last time user connected to internet
  // Throws CacheException if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaCache);
}