import 'package:flutter/material.dart';
import 'package:minefield/models/field.dart';

import '../components/choose_difficulty_widget.dart';
import '../components/gameboard_widget.dart';
import '../components/result_widget.dart';
import '../models/explosion_exception.dart';
import '../models/gameboard.dart';

class MineFieldApp extends StatefulWidget {
  const MineFieldApp({Key? key}) : super(key: key);

  @override
  State<MineFieldApp> createState() => _MineFieldAppState();
}

class _MineFieldAppState extends State<MineFieldApp> {
  double? _difficulty;
  bool? _won;
  GameBoard? _gameBoard;

  void _restart() {
    setState(() {
      _won = null;
      _gameBoard = null;
    });
  }

  Future<void> _changeDifficulty() async {
    bool change = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Do you really want to change game difficulty?'),
        contentPadding: const EdgeInsets.only(
          left: 24.0,
          top: 20.0,
          right: 24.0,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                style: TextButton.styleFrom(primary: Colors.red),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    );

    if (change) {
      setState(() {
        _difficulty = null;
        _won = null;
        _gameBoard = null;
      });
    }
  }

  void _open(Field field) {
    if (!_isFinishedGame) {
      setState(() {
        try {
          field.open();
          _checkIfWonGame();
        } on ExplosionException {
          _won = false;
          _gameBoard?.revealMines();
        }
      });
    } else {
      _showErrorMessage();
    }
  }

  void _toggleMark(Field field) {
    if (!_isFinishedGame) {
      setState(() {
        field.toggleMark();
        _checkIfWonGame();
      });
    } else {
      _showErrorMessage();
    }
  }

  bool get _isFinishedGame => _won != null;

  void _checkIfWonGame() {
    if (_gameBoard?.isSolved ?? false) {
      _won = true;
    }
  }

  void _showErrorMessage() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Finished Game!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
              'You have finished this game! Start a new one by clicking the emoticon result or "Restart".'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _restart();
                  },
                  child: const Text('Restart'),
                ),
              ],
            ),
          ],
          contentPadding: const EdgeInsets.only(
            top: 12,
            left: 24,
            right: 24,
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 5),
        ),
      );
    }
  }

  GameBoard _getGameBoard(double width, double height) {
    if (_gameBoard == null && _difficulty != null) {
      int columnsQtt = 15;
      double fieldLength = width / columnsQtt;
      int rowsQtt = (height / fieldLength).floor();

      _gameBoard = GameBoard(
        rows: rowsQtt,
        columns: columnsQtt,
        minesQtt: ((rowsQtt * columnsQtt) / _difficulty!).ceil(),
      );
    }

    return _gameBoard!;
  }

  void _onChooseDifficulty(double difficulty) {
    setState(() {
      _difficulty = difficulty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _difficulty == null
        ? ChooseDifficultyWidget(
            onChooseDifficulty: _onChooseDifficulty,
          )
        : Scaffold(
            appBar: ResultWidget(
              won: _won,
              onRestart: _restart,
              onChangeDifficulty: _changeDifficulty,
            ),
            body: Container(
              color: Colors.grey,
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  return GameBoardWidget(
                    gameBoard: _getGameBoard(
                      constraints.maxWidth,
                      constraints.maxHeight,
                    ),
                    onOpen: _open,
                    onToggleMark: _toggleMark,
                  );
                },
              ),
            ),
          );
  }
}
