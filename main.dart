import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final Store<int> store = Store(reducer, initialState: 0);
  runApp(StoreProvider(store: store, child: MaterialApp(home: _Counter())));
}

class _Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<int> store = StoreProvider.of<int>(context);
    final dispatch = store.dispatch;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('counter'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dispatch(AddAction()),
        child: Icon(Icons.add),
      ),
      body: Center(
        child: StoreConnector<int, int>(
          converter: (store) => store.state,
          builder: (context, state) => Text(
            state.toString(),
            style: TextStyle(
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}

class AddAction {}

int reducer(int state, dynamic action) {
  if (action is AddAction) {
    return state + 1;
  } else {
    return state;
  }
}
