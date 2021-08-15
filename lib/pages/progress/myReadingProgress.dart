import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';

import 'components/appbar.dart';

class MyReadingProgress extends StatefulWidget {
  @override
  _MyReadingProgressState createState() => _MyReadingProgressState();
}

class _MyReadingProgressState extends State<MyReadingProgress> {
  Map<String, List<dynamic>> _map;
  @override
  void initState() {
    super.initState();
    // Get old data or init empty map
    try {
      _map = MyDB().getJournalProgress(MyResource.READING_JOURNAL);
    } catch (e) {
      print('error get reading progress');
      myDbBox.put(MyResource.READING_JOURNAL, {});
      _map = MyDB().getJournalProgress(MyResource.READING_JOURNAL);
    }
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
            appBarProgress('my_books'.tr),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 0),
                child: GridView(
                  padding: EdgeInsets.only(bottom: 15),
                  children: _map.isNotEmpty
                      ? List.generate(
                          _map.length,
                          (index) => ReadingMiniProgress(
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

class ReadingMiniProgress extends StatelessWidget {
  final String id;
  final String date;
  final List<dynamic> list;

  ReadingMiniProgress(this.id, this.list, this.date);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
            builder: (context) => ReadingFullProgress(id, list, date)));
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
                    list.last.book,
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
                      Text(date)
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

class ReadingFullProgress extends StatefulWidget {
  String id;
  String date;
  List<dynamic> list;

  ReadingFullProgress(this.id, this.list, this.date);

  @override
  _ReadingFullProgressState createState() => _ReadingFullProgressState();
}

class _ReadingFullProgressState extends State<ReadingFullProgress> {
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
            appBarProgress('my_books'.tr),
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
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Icon(Icons.access_time),
                              ),
                              SizedBox(width: 10),
                              Text(widget.date),
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
          String skip =
              widget.list[i].isSkip ? '( ' + 'skip_note'.tr + ' )' : '';
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
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
                  flex: 2,
                  child: Text(
                    '${widget.list[i].pages}' + ' ' + 'pages_short'.tr,
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
                    '${widget.list[i].book} $skip',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
