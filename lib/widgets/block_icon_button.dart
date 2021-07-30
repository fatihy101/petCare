import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlockIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color color;
  final Widget icon;
  final String? text;
  final Text? textWidget;

  const BlockIconButton(
      {Key? key,
      this.onPressed,
      this.text,
      required this.color,
      required this.icon,
      this.textWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(StadiumBorder()),
        elevation: MaterialStateProperty.all(10),
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 45)),
      ),
      icon: icon,
      label: text != null ? Text(
        text!,
        style: GoogleFonts.courgette(fontSize: 20, color: Colors.white),
      ): textWidget!,
    );
  }
}
