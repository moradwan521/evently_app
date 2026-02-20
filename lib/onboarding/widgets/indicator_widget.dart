import 'package:flutter/cupertino.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({super.key, required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: active ? Color(0xff0E3A99) : Color(0xffB9B9B9),
        borderRadius: BorderRadius.circular(36),
      ),
      width: active ? 21 : 8,
      height: 8,
      margin: EdgeInsets.all(6),

    );
  }
}
