import 'package:flutter/material.dart';

import '../models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onToggleMark;

  const FieldWidget({
    Key? key,
    required this.field,
    required this.onOpen,
    required this.onToggleMark,
  }) : super(key: key);

  Widget _getImage() {
    if (field.isOpen && field.isMined && field.isExploded) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.isOpen && field.isMined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.isOpen) {
      return Image.asset(
          'assets/images/aberto_${field.neighborhoodMinesQtt}.jpeg');
    } else if (field.isMarked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onOpen(field),
      child: _getImage(),
    );
  }
}
