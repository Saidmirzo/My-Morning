import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/pages/progress/components/appbar.dart';
import 'package:morningmagic/resources/colors.dart';

class MyFitnessProgress extends StatefulWidget {
  @override
  _MyFitnessProgressState createState() => _MyFitnessProgressState();
}

class _MyFitnessProgressState extends State<MyFitnessProgress> {
  List<dynamic> list;
  @override
  void initState() {
    super.initState();
    list = MyDB().getBox().get(MyResource.FITNESS_PROGRESS) ?? [];
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // match parent(all screen)
        height: MediaQuery.of(context).size.height, // match parent(all screen)
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT,
            ],
          ),
        ),
        //SingleChildScrollView
        child: Column(
          children: [
            appBarProgress('my_exercises'.tr),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 0),
                child: GridView(
                  padding: EdgeInsets.only(bottom: 15),
                  children: list.isNotEmpty
                      ? List.generate(
                          list.length,
                          (index) => FitnessMiniProgress(
                            list.isNotEmpty ? list[index][0] : '0',
                            list.isNotEmpty ? list[index][1] : '',
                            list.isNotEmpty ? list[index][2] : '01.01.2020',
                          ),
                        )
                      : [],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                    childAspectRatio: 5 / 4.1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FitnessMiniProgress extends StatelessWidget {
  final String id;
  final String text;
  final String date;

  FitnessMiniProgress(this.id, this.text, this.date);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => FitnessFullProgress(id, text, date)));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: id,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectCategory(context),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            margin: const EdgeInsets.only(
              bottom: 15,
              left: 5,
              right: 5,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04, //16,
                      color: Colors.black54,
                    ),
                    //style: Theme.of(context).textTheme.title,
                  ),
                ),
                Spacer(),
                Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.access_time),
                      ),
                      Text(
                        date,
                        style: TextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(width: 1, color: AppColors.BLUE),
            ),
          ),
        ),
      ),
    );
  }
}

class FitnessFullProgress extends StatefulWidget {
  String id;
  String text;
  String date;

  FitnessFullProgress(this.id, this.text, this.date);

  @override
  _FitnessFullProgressState createState() => _FitnessFullProgressState();
}

class _FitnessFullProgressState extends State<FitnessFullProgress> {
  List<dynamic> list;
  List<dynamic> tempList;
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT,
            ],
          ),
        ),
        child: Column(
          children: [
            appBarProgress('my_exercises'.tr),
            Expanded(
              child: Hero(
                tag: widget.id,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        bottom: 15, left: 5, right: 5, top: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(Icons.access_time),
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                widget.date,
                                style: TextStyle(),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: TextField(
                            controller: controller,
                            maxLines: 100,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            // enabled: true,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.04, //16,
                              color: Colors.black54,
                            ),
                            //style: Theme.of(context).textTheme.title,
                          )),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(width: 1, color: AppColors.BLUE),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
