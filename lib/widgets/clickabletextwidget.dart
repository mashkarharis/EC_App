import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String normaltext;
  final String clickabletext;
  final Function ontap;
  final BuildContext parentContext;
  final double fsize;

  ClickableText(Key? key, this.normaltext, this.clickabletext, this.ontap,
      this.fsize, this.parentContext)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: normaltext,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        TextSpan(
            text: clickabletext,
            style: TextStyle(
              fontSize: fsize,
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => ontap.call(parentContext)),
      ]),
    );
  }
}
