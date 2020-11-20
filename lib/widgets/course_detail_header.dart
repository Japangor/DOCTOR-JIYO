import '../screens/youtube_screen.dart';

import '../widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/star_display_widget.dart';
import '../models/prescription.dart';
import '../widgets/youtube_player_widget.dart';

class CourseDetailHeader extends StatelessWidget {
  final Prescription loadedCourse;
  CourseDetailHeader({@required this.loadedCourse});

  void _showYoutubeModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return YoutubePlayerWidget(
          newKey: UniqueKey(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: loadedCourse.prespatname,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: 80,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      bottom: -30,
                      right: 50,
                      child: ClipOval(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage('assets/images/play.png'),
                                fit: BoxFit.contain),
                            boxShadow: [kDefaultShadow],
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              _showYoutubeModal(context);
                              // Navigator.of(context).pushNamed(
                              //     YoutubeScreen.routeName,
                              //     arguments: loadedCourse.id);
                            },
                            child: null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.school,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
