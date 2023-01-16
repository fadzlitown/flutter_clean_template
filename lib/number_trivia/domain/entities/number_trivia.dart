import 'package:equatable/equatable.dart';

///todo -> 1. Create Entity
class NumberTrivia extends Equatable{

  final String text;
  final int number;

  NumberTrivia({required this.text, required this.number});

  @override
  List<Object?> get props => [text,number];

}