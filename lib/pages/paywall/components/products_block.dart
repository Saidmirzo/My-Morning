import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:morningmagic/pages/paywall/paywall_provider.dart';
import 'package:provider/provider.dart';

class ProductsBlockPaywall extends StatefulWidget {
  const ProductsBlockPaywall({
    Key key,
    @required this.productsList,
  }) : super(key: key);

  final List<Map<String, dynamic>> productsList;
  @override
  State<ProductsBlockPaywall> createState() => _ProductsBlockPaywallState();
}

class _ProductsBlockPaywallState extends State<ProductsBlockPaywall> {
  @override
  Widget build(BuildContext context) {
    PayWallProvider prov = context.watch<PayWallProvider>();
    return Expanded(
      flex: 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(
            widget.productsList.length,
            (i) => ProductsBlockItem(
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
      ),
    );
  }
}

class ProductsBlockItem extends StatelessWidget {
  ProductsBlockItem({
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

  final containerDecoration = BoxDecoration(
    border: Border.all(
      color: const Color(0xff6B0496),
      width: 3,
    ),
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: onClicked,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: 12.5,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: containerDecoration,
                ),
              ),
              Positioned(
                top: 12.5,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                        img,
                      ),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // blur
              if (isClosed)
                Positioned(
                  top: 12.3,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              if (isPopular ?? false)
                Positioned(
                  top: 0,
                  left: size.width / 17.2,
                  right: size.width / 17.2,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.5),
                      color: const Color(0xffFF5C5C),
                    ),
                    child: const Text(
                      "-50%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 12.5,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width / 22, right: size.width / 11),
                      child: FittedBox(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 22,
                      ),
                      child: FittedBox(
                        child: Text(
                          description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
