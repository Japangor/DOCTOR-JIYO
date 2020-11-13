import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constants.dart';
import '../widgets/star_display_widget.dart';
import '../screens/my_course_detail_screen.dart';
import '../models/my_course.dart';
import '../widgets/custom_text.dart';

class MyCoureGrid extends StatelessWidget {
  final MyCourse myCourse;

  MyCoureGrid({
    @required this.myCourse,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MyCourseDetailScreen.routeName, arguments: myCourse.id);
      },
      child: Container(
        width: double.infinity,
        // height: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 42,
                        child: ListTile(
                          title: Text(myCourse.recordname),
                        )),
                    Container(
                        height: 42,
                        child: ListTile(
                          title: Text(myCourse.recordcat),
                        )),
                    Container(
                        height: 42,
                        child: ListTile(
                          title: Text(myCourse.recordnotes),
                        )),
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
