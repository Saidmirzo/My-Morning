import 'package:flutter/cupertino.dart';

class FeatureItem extends StatelessWidget {
  final String img;
  final String text;

  const FeatureItem({
    Key key,
    this.img,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.8,
      child: Column(
        children: [
          SizedBox(
            height: 94,
            width: 94,
            child: Image.asset(img),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
