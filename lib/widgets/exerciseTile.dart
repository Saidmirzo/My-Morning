import 'package:get/get.dart';
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Container(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      color: AppColors.VIOLET,
                      fontSize: 20,
                      fontStyle: FontStyle.normal),
                ),
              ),
            )),
            Container(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 3, top: 3),
                    child: Text(
                      'min'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.normal,
                          color: AppColors.VIOLET,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Container(
                    width: 64,
                    padding: EdgeInsets.only(bottom: 8),
                    child: _buildMinutesTextInput(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextField _buildMinutesTextInput() {
    return TextField(
      controller: textEditingController,
      minLines: 1,
      maxLines: 1,
      cursorColor: AppColors.VIOLET,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      enabled: trues ? true : false,
      decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.all(6),
          isDense: true,
          fillColor:
              trues ? AppColors.TRANSPARENT_WHITE : AppColors.TRANSPARENTS,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.VIOLET),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.CREAM),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      style: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          color: AppColors.VIOLET,
          decoration: TextDecoration.none),
    );
  }
}
