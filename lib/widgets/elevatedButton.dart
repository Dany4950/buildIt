import 'package:buildittt/utils/appTheme.dart';
import 'package:flutter/material.dart';

class elevatedButtonYellow extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final TextStyle? textStyle;

  const elevatedButtonYellow({
    Key? key,
    required this.text,
    this.width = 230.0, // Default width
    this.height = 60.0, // Default height
    this.color = Apptheme.buttonColorYellow,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        width: width,
        height: height,
        color: color,
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle ??
              const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
        ),
      ),
    );

    // return Container(
    //   width: width,
    //   height: height,
    //   color: color,
    //   alignment: Alignment.center,
    //   child: Text(
    //     text,
    //     style: textStyle ??
    //         const TextStyle(
    //             fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
    //   ),
    // );
  }
}
