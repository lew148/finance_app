import 'package:flutter/material.dart';

class GreyBackground extends StatefulWidget {
  final Widget child;
  final double height;

  const GreyBackground({Key? key, required this.child, this.height = 0})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _GreyBackgroundState();
}

class _GreyBackgroundState extends State<GreyBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      height: widget.height == 0 ? null : widget.height,
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
    );
  }
}
