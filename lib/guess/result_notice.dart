import 'package:flutter/material.dart';

class ResultNotice extends StatelessWidget {
  const ResultNotice({super.key, this.info = "", this.color = Colors.red});

  final String info;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(color: color));
  }
}
