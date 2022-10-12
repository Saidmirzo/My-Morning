
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/paywall/components/safety_shield.dart';
import 'package:morningmagic/resources/svg_assets.dart';
import 'package:provider/provider.dart';

import '../paywall_provider.dart';

class Products extends StatefulWidget {
  const Products({
    Key key,
    @required this.productsList,
  }) : super(key: key);

  final List<Map<String, dynamic>> productsList;
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    PayWallProvider prov = context.watch<PayWallProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: List.generate(
          widget.productsList.length,
              (i) => Product(
            name: widget.productsList[i]["name"],
            description: widget.productsList[i]["description"],
            isPopular: widget.productsList[i]["isPopular"],
            isClosed: prov.openedProductIndex != i,
            img: widget.productsList[i]["img"],
            onClicked: () {
              prov.changeIndex(i);
            },
          ),
        ),
      ),
    );
  }
}

class Product extends StatelessWidget {
  Product({
    Key key,
    @required this.name,
    @required this.description,
    @required this.isPopular,
    @required this.isClosed,
    @required this.img,
    @required this.onClicked,
  }) : super(key: key);

  final String name;
  final String description;
  final bool isPopular;
  final bool isClosed;
  final String img;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {

    const textStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
    );

    return GestureDetector(
      onTap: onClicked,
      // Белый блок
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.84),
        // height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Сумма
            SizedBox(
              height: 35,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(description,
                  style: textStyle.copyWith(
                    color: const Color(0xFF6B0496),
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            // Период
            SizedBox(
              height: 22,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(name,
                  style: textStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Серый блок
            const SafetyShield(),
          ],
        ),
      ),
    );
  }
}