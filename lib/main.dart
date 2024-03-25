// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('com.example/native');

  static void getNativeData(int num) async {
    await _channel.invokeMethod('getNativeData', <String, int>{
      "num": num,
    }).then((value) => print(value));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    int i = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NativeBridge.getNativeData(++i);
          },
          child: const Text('Click me'),
        ),
      ),
    );
  }
}
