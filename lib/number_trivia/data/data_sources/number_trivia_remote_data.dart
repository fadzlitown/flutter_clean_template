import 'dart:convert';

import 'package:flutter_clean_arch_template/core/error/server_exceptions.dart';
import 'package:http/http.dart';

import '../models/number_trivia_model.dart';

// From the external API remote data source
abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource{
  final Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) => _getTriviaFromUrl('http://numbersapi.com/$number');
    // TODO: call http://numbersapi.com/$number API endpoint else return ServerException

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl('http://numbersapi.com/random');
  // TODO: call http://numbersapi.com/random API endpoint else return ServerException


  Future<NumberTriviaModel> _getTriviaFromUrl(String path) async {
    final url = Uri.http(path);
    final response = await client.get(url, headers: {'Content-Type': 'application/json'});

    //check the server status
    if(response.statusCode==200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerExceptions();
    }
  }

}
