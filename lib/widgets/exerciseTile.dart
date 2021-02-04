import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morningmagic/resources/colors.dart';

class ExerciseTile extends StatelessWidget {
  final int id;
  final bool trues;
  final String title;
  final EdgeInsets edgeInsets;
  final TextEditingController textEditingController;

  const ExerciseTile(
      {Key key,
      @required this.id,
      @required this.trues,
      @required this.title,
      @required this.edgeInsets,
      @required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: trues ? AppColors.TRANSPARENT_WHITE : AppColors.TRANSPARENTS,
          borderRadius: BorderRadius.all(Radius.circular(45)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: AppColors.VIOLET,
                          fontSize: 20,
                          fontFamily: 'sans-serif',
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text(
                        'min'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: "sans-serif",
                            fontStyle: FontStyle.normal,
                            color: AppColors.VIOLET,
                            decoration: TextDecoration.none),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                          width: 60,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color:  trues
                                ? AppColors.TRANSPARENT_WHITE
                                : AppColors.TRANSPARENTS,
                          )),
                    ],
                  ),
                  Container(
                    height: 57,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: TextField(
                        enabled: trues ? true : false,
                        decoration: null,
                        controller: textEditingController,
                        maxLines: 1,
                        cursorColor: AppColors.VIOLET,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "sans-serif",
                          color: AppColors.VIOLET,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
