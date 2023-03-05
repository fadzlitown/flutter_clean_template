import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_template/injection_container.dart';
import 'package:flutter_clean_arch_template/number_trivia/presentation/bloc/number_trivia_state_bloc.dart';
import 'package:flutter_clean_arch_template/number_trivia/presentation/widgets/trivia_controls.dart';

import '../widgets/message_display.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Main Screen'),
    ),
        body: BlocProvider(create: (_) => injector<NumberTriviaStateBloc>(),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(height: 10),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                child: BlocBuilder<NumberTriviaStateBloc, NumberTriviaStateState>(
                  builder: (context, state) {
                    if(state is Empty) {
                      return const MessageDisplay(message: 'Start searching');
                    } else if(state is Loading) {
                      return const CircularProgressIndicator();
                    } else if(state is Loaded) {
                      return TriviaDisplay(numberTrivia: state.trivia);
                    } else if(state is Error) {
                      return MessageDisplay(message: state.message);
                    }
                    return const Placeholder();
                  },
                ),
              ),
              const TriviaControls()
            ],),
          )),
        ));
  }
}
