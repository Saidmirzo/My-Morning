import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionDialog extends StatelessWidget {
  const ConnectionDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Text('check internet connection'.tr ,textAlign: TextAlign.center,style: const TextStyle(fontSize: 18),),
                                  const SizedBox(height: 20,),
                                ElevatedButton(onPressed: ()=> Get.back(), child: const Text("Ok"),),
                                ],
                              ),
                            ),
                            
                          );
  }
}