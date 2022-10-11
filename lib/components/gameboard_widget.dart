import 'package:flutter/material.dart';

import '../models/field.dart';
import '../models/gameboard.dart';
import 'field_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final GameBoard gameBoard;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMark;

  const GameBoardWidget({
    Key? key,
    required this.gameBoard,
    required this.onOpen,
    required this.onToggleMark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: gameBoard.columns,
      children: gameBoard.fields.map((field) {
        return FieldWidget(
          field: field,
          onOpen: onOpen,
          onToggleMark: onToggleMark,
        );
      }).toList(),
    );
  }
}
