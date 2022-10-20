import 'package:flutter/material.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class CounterItem extends StatelessWidget {

  final num;
  final Color color;

  const CounterItem({
    Key key,
    @required this.num,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(4),
      height: 120,
      width: 70,
      child: Center(
        child: Text('$num',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 64,
            color: color,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
