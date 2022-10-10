import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/gameboard.dart';

main() {
  group('GameBoard', () {
    test('Win game', () {
      GameBoard gameBoard = GameBoard(
        rows: 2,
        columns: 2,
        minesQtt: 0,
      );

      gameBoard.fields[0].mine();
      gameBoard.fields[3].mine();

      gameBoard.fields[0].toggleMark();
      gameBoard.fields[1].open();
      gameBoard.fields[2].open();
      gameBoard.fields[3].toggleMark();

      expect(gameBoard.isSolved, isTrue);
    });

    test('Lose game', () {
      GameBoard gameBoard = GameBoard(
        rows: 2,
        columns: 2,
        minesQtt: 0,
      );

      gameBoard.fields[0].mine();
      gameBoard.fields[3].mine();

      gameBoard.fields[0].toggleMark();
      gameBoard.fields[1].open();
      gameBoard.fields[2].open();

      expect(gameBoard.fields[3].open, throwsException);
    });
  });
}
