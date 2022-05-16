import 'package:flutter/cupertino.dart';

class CustomTextWidget extends StatelessWidget {
  final double maxwidth;
  final String text;
  final TextAlign align;
  final FontWeight weight;
  final Color color;
  final double size;

  const CustomTextWidget(Key? key, this.maxwidth, this.text, this.align,
      this.color, this.size, this.weight)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * maxwidth,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(color: color, fontSize: size, fontWeight: weight),
      ),
    );
  }
}
