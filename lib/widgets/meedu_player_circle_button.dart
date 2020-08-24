import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeeduPlayerCircleButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const MeeduPlayerCircleButton(
      {Key key, @required this.iconPath, this.onPressed})
      : assert(iconPath != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(10),
        child: Image.asset(
          this.iconPath,
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
