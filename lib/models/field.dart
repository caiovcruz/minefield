import 'explosion_exception.dart';

class Field {
  final int row;
  final int column;
  final List<Field> neighbors = [];

  bool _isOpen = false;
  bool _isMarked = false;
  bool _isMined = false;
  bool _isExploded = false;

  Field({
    required this.row,
    required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_isOpen) {
      return;
    }

    _isOpen = true;

    if (_isMined) {
      _isExploded = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      for (var neighbor in neighbors) {
        neighbor.open();
      }
    }
  }

  void revealMine() {
    if (_isMined) {
      _isOpen = true;
    }
  }

  void mine() {
    _isMined = true;
  }

  void toggleMark() {
    _isMarked = !_isMarked;
  }

  void restart() {
    _isOpen = false;
    _isMarked = false;
    _isMined = false;
    _isExploded = false;
  }

  bool get isMined => _isMined;

  bool get isExploded => _isExploded;

  bool get isOpen => _isOpen;

  bool get isMarked => _isMarked;

  bool get isSolved {
    bool minedAndMarked = isMined && isMarked;
    bool safeAndOpen = !isMined && isOpen;
    return minedAndMarked || safeAndOpen;
  }

  bool get safeNeighborhood =>
      neighbors.every((neighbor) => !neighbor._isMined);

  int get neighborhoodMinesQtt =>
      neighbors.where((neighbor) => neighbor.isMined).length;
}
