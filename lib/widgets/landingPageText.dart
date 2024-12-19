import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final TextStyle? textStyle;

  const TextContainer({
    Key? key,
    required this.text,
    this.width = 230.0, // Default width
    this.height = 60.0, // Default height
    this.color = const Color.fromRGBO(21, 21, 33, 255),


    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
      ),
    );
  }
}
