import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// En entrée
abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

// En sortie
abstract class CounterState {
  final int value;

  CounterState(this.value);
}

class InitialCounterState extends CounterState {
  InitialCounterState() : super(0);
}

class IncrementedCounterState extends CounterState {
  IncrementedCounterState(int value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _counter = 0;

  // Donner la valeur initiale
  CounterBloc() : super(InitialCounterState());

  void incrementCounter() {
    add(IncrementCounterEvent());
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementCounterEvent) {
      _counter++;
      yield IncrementedCounterState(_counter);
    }
  }
}

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (BuildContext context, CounterState state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.value.toString(),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<CounterBloc>(context).incrementCounter();
                    },
                    child: Text('+1'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
