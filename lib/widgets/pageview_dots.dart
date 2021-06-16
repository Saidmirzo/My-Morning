import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageViewDots extends StatefulWidget {
  /// Page controller
  final PageController controller;

  /// Count of pages
  final int countPages;

  /// Inactive color
  final Color activeColor;

  /// Active color
  final Color inactiveColor;

  const PageViewDots({
    Key key,
    this.countPages = 1,
    @required this.controller,
    this.activeColor = Colors.black87,
    this.inactiveColor = Colors.black26,
  }) : super(key: key);

  @override
  _PageViewDotsState createState() => _PageViewDotsState();
}

class _PageViewDotsState extends State<PageViewDots> {
  var _page = new ValueNotifier<int>(0);

  @override
  void initState() {
    widget.controller.addListener(() {
      _page.value = (widget.controller.page ?? 0).round();
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _page,
      builder: (context, value, child) => Container(
        height: 3,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.countPages,
          itemBuilder: (_, i) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: value >= i ? widget.activeColor : widget.inactiveColor,
            ),
            width:
                (MediaQuery.of(context).size.width * .8) / (widget.countPages),
          ),
        ),
      ),
    );
  }
}
