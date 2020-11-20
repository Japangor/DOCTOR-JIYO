import 'package:doctor/screens/pres.dart';

import '../screens/youtube_screen.dart';

import '../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/star_display_widget.dart';
import '../models/model.dart';
import '../widgets/youtube_player_widget.dart';
import '../screens/courses_screen.dart';

class MyCourseDetailHeader extends StatelessWidget {
  final int id;
  final String title;
  final String thumbnail;
  final int rating;
  final String price;
  final fetchdataa loadedCourse;

  MyCourseDetailHeader(
      {@required this.id,
      @required this.title,
      @required this.thumbnail,
      @required this.rating,
      @required this.price,
      @required this.loadedCourse});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: loadedCourse.patientname,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      flexibleSpace: Image.network(
        loadedCourse.thumbnail,
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Row(
          children: <Widget>[
            ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: InkWell(
                      splashColor: Colors.red, // inkwell color
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset('assets/images/icon_email.png')),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pres()),
                        );
                      },
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
