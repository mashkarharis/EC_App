import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final IconData icononbutton;
  final Color foregroundcolor;
  final Color backgroundcolor;
  final Function(BuildContext context) onpressedrun;
  final String text;
  final double width;
  final BuildContext parentContext;

  RoundedButton(
      Key? key,
      this.icononbutton,
      this.foregroundcolor,
      this.backgroundcolor,
      this.onpressedrun,
      this.text,
      this.width,
      this.parentContext)
      : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(
          widget.icononbutton,
          color: widget.foregroundcolor,
        ),
        onPressed: () {
          widget.onpressedrun.call(widget.parentContext);
        },
        label: Text(
          widget.text,
          style: TextStyle(fontSize: 16, color: widget.foregroundcolor),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: widget.backgroundcolor,
          fixedSize: Size(MediaQuery.of(context).size.width * widget.width, 53),
        ),
      ),
    );
  }
}
