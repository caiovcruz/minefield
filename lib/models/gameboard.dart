import 'dart:math';

import 'field.dart';

class GameBoard {
  final int rows;
  final int columns;
  final int minesQtt;

  final List<Field> _fields = [];

  GameBoard({
    required this.rows,
    required this.columns,
    required this.minesQtt,
  }) {
    _createFields();
    _relateNeighbors();
    _raffleMines();
  }

  void restart() {
    for (var field in _fields) {
      field.restart();
    }
    _raffleMines();
  }

  void revealMines() {
    for (var field in _fields) {
      field.revealMine();
    }
  }

  void _createFields() {
    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < columns; col++) {
        _fields.add(Field(row: row, column: col));
      }
    }
  }

  void _relateNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _raffleMines() {
    int raffleds = 0;

    if (minesQtt > (rows * columns)) {
      return;
    }

    while (raffleds < minesQtt) {
      int i = Random().nextInt(_fields.length);

      if (!_fields[i].isMined) {
        _fields[i].mine();
        raffleds++;
      }
    }
  }

  List<Field> get fields => _fields;

  bool get isSolved => _fields.every((field) => field.isSolved);
}
