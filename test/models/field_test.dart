import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/field.dart';

main() {
  group('Field', () {
    test('Open field WITH explosion', () {
      Field field = Field(row: 0, column: 0);
      field.mine();

      expect(field.open, throwsException);
    });

    test('Open field WITHOUT explosion', () {
      Field field = Field(row: 0, column: 0);
      field.open();

      expect(field.isOpen, isTrue);
    });

    test('Add NOT neighbor', () {
      Field field = Field(row: 0, column: 0);
      Field fieldNotNeighbor = Field(row: 1, column: 3);
      field.addNeighbor(fieldNotNeighbor);

      expect(field.neighbors.isEmpty, isTrue);
    });

    test('Add neighbor', () {
      Field field = Field(row: 3, column: 3);
      Field fieldNeighbor1 = Field(row: 3, column: 4);
      Field fieldNeighbor2 = Field(row: 2, column: 2);
      Field fieldNeighbor3 = Field(row: 4, column: 4);
      field.addNeighbor(fieldNeighbor1);
      field.addNeighbor(fieldNeighbor2);
      field.addNeighbor(fieldNeighbor3);

      expect(field.neighbors.length, 3);
    });

    test('Mines in Neighborhood', () {
      Field field = Field(row: 3, column: 3);
      Field fieldNeighbor1 = Field(row: 3, column: 4);
      fieldNeighbor1.mine();
      Field fieldNeighbor2 = Field(row: 2, column: 2);
      fieldNeighbor2.mine();
      Field fieldNeighbor3 = Field(row: 4, column: 4);
      field.addNeighbor(fieldNeighbor1);
      field.addNeighbor(fieldNeighbor2);
      field.addNeighbor(fieldNeighbor3);

      expect(field.neighborhoodMinesQtt, 2); 
    });
  });
}
