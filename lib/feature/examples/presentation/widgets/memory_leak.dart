import 'package:flutter/material.dart';

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final CounterNotifier _counterNotifier = CounterNotifier();

  @override
  void initState() {
    super.initState();
    _counterNotifier.addListener(() {
      print('Count updated: ${_counterNotifier.count}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${_counterNotifier.count}'),
            ElevatedButton(
              onPressed: () => _counterNotifier.increment(),
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }

// Missing dispose method
// @override
// void dispose() {
//   _counterNotifier.dispose();
//   super.dispose();
// }
}