import 'package:flutter/material.dart';

extension ColorX on String {
  Color parseColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Color color(BuildContext context, Color dark, Color light) {
  return Theme.of(context).brightness == Brightness.dark ? dark : light;
}
