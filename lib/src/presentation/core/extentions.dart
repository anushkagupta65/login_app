import 'package:flutter/material.dart';

Color color(BuildContext context, Color dark, Color light) {
  return Theme.of(context).brightness == Brightness.dark ? dark : light;
}
