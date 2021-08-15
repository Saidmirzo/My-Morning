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
  Map<String, List<dynamic>> _map;
  @override
  void initState() {
    super.initState();
    // Get old data or init empty map
    _map = MyDB().getJournalProgress(MyResource.FITNESS_JOURNAL);
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
        child: Column(
          children: [
            appBarProgress('my_exercises'.tr),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 0),
                child: GridView(
                  padding: EdgeInsets.only(bottom: 15),
                  children: _map.isNotEmpty
                      ? List.generate(
                          _map.length,
                          (index) => FitnessMiniProgress(
                            _map.keys.toList()[index],
                            _map[_map.keys.toList()[index]],
                            _map.keys.toList()[index],
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
  final List<dynamic> list;
  final String date;

  FitnessMiniProgress(this.id, this.list, this.date);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => FitnessFullProgress(id, list, date)));
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
                    list.last.text,
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
  List<dynamic> list;
  String date;

  FitnessFullProgress(this.id, this.list, this.date);

  @override
  _FitnessFullProgressState createState() => _FitnessFullProgressState();
}

class _FitnessFullProgressState extends State<FitnessFullProgress> {
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
                        list(),
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

  Expanded list() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (ctx, i) {
          var prog = widget.list[i].progName;
          String skip =
              widget.list[i].isSkip ? '( ' + 'skip_note'.tr + ' )' : '';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prog != null &&
                  (i == 0 || prog != widget.list[i - 1].progName)) ...[
                const SizedBox(height: 20),
                Text(
                  widget.list[i].progName,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${widget.list[i].sec}' + ' ' + 'sec'.tr,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        '${widget.list[i].text} $skip',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
