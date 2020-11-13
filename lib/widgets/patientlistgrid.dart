import 'package:doctor/screens/patientdetails.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../constants.dart';
import '../widgets/star_display_widget.dart';
import '../screens/patientlistattend.dart';
import '../models/my_course.dart';
import '../widgets/custom_text.dart';

class patientlistgrid extends StatelessWidget {
  final MyCourse myCourse;

  patientlistgrid({
    @required this.myCourse,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(patientdetails.routeName, arguments: myCourse.id);
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
                    child: Image.network(
                      myCourse.thumbnail,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                      child: Customtext(
                        text: myCourse.patientname.length < 38
                            ? myCourse.patientname
                            : myCourse.patientname.substring(0, 37),
                        fontSize: 14,
                        colors: kTextLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
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
