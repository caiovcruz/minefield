import 'package:flutter/material.dart';

import '../components/result_widget.dart';

class MineFieldApp extends StatelessWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  void _restart() {
    print('restarting...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: null,
          onRestart: _restart,
        ),
        body: Container(
          alignment: Alignment.center,
          child: const Text('GameBoard'),
        ),
      ),
    );
  }
}
