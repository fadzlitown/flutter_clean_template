import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_template/number_trivia/presentation/bloc/number_trivia_state_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({Key? key}) : super(key: key);


  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  var textController = TextEditingController();
  late String inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: textController,
        keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onChanged: (value){
            inputStr = value;
          },
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: addConcrete,
                child: const Text('Search'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade500,
                ),
                onPressed: addRandom,
                child: const Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void addConcrete() {
    textController.clear();
    //UI Widget --> BLOC Event (Presentation)
    context.read<NumberTriviaStateBloc>().add(GetNumberConcreteTrivia(inputStr));
  }

  void addRandom() {
    textController.clear();
    //UI Widget --> BLOC Event (Presentation)
    context.read<NumberTriviaStateBloc>().add(GetRandomNumberConcreteTrivia());
  }
}
