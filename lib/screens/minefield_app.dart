import 'package:flutter/material.dart';
import 'package:minefield/models/field.dart';

import '../components/field_widget.dart';
import '../components/result_widget.dart';
import '../models/explosion_exception.dart';

class MineFieldApp extends StatelessWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  void _restart() {
    print('restarting...');
  }

  void _open(Field field) {
    print('opening...');
  }

  void _toggleMark(Field field) {
    print('marking...');
  }

  @override
  Widget build(BuildContext context) {
    Field fieldNeighbor = Field(row: 1, column: 0);
    fieldNeighbor.mine();

    Field field = Field(row: 0, column: 0);
    field.addNeighbor(fieldNeighbor);

    try {
      // field.mine();
      field.toggleMark();
    } on ExplosionException catch (error) {
      print(error);
    }

    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: null,
          onRestart: _restart,
        ),
        body: Container(
          child: FieldWidget(
            field: field,
            onOpen: _open,
            onToggleMark: _toggleMark,
          ),
        ),
      ),
    );
  }
}
