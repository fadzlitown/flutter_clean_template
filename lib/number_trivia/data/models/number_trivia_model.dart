import 'package:flutter_clean_arch_template/number_trivia/domain/entities/number_trivia.dart';

//todo 6 - Model need to extends to Domain Entity
// Models are entities with some additional functionality added on top.
// Ability to be serialized and deserialized to/from JSON & conversion logic. -> required TDD
class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({required super.text, required super.number});

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(text: json['text'], number: (json['number'] as num).toInt());  //dart has datatype called "num" == can be both INTEGER & DOUBLE
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
