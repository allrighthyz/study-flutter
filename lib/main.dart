import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterState(),
      child: const MyApp(),
    ),
  );
}

class CounterState extends ChangeNotifier {
  int _counter = 0;
  String _current = 'ready';

  int get counter => _counter;
  String get current => _current;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void updateCurrent() {
    _current = WordPair.random().asPascalCase;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('增加:'),
            CounterDisplay(),
            SizedBox(height: 10),
            IdeaCard(),
            CurrentDisplay(),
            SizedBox(height: 10),
            NextButton(),
          ],
        ),
      ),
      floatingActionButton: const IncrementButton(),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var counter = context.watch<CounterState>().counter;
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class IdeaCard extends StatelessWidget {
  const IdeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'A random AWESOME idea:',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class CurrentDisplay extends StatelessWidget {
  const CurrentDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var current = context.watch<CounterState>().current;
    return Text(
      current,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterState>().updateCurrent();
      },
      child: const Text('Next'),
    );
  }
}

class IncrementButton extends StatelessWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CounterState>().increment();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
