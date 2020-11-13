import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share/share.dart';
import '../providers/my_courses.dart';
import '../widgets/video_player_widget.dart';
import '../widgets/my_course_header.dart';
import '../widgets/custom_text.dart';
import '../constants.dart';
import '../models/common_functions.dart';
import '../screens/course_detail_screen.dart';
import '../widgets/my_course_detail_header.dart';
import '../widgets/youtube_player_widget.dart';
import '../screens/webview_screen.dart';
import '../screens/webview_screen_iframe.dart';
import '../screens/temp_view_screen.dart';
import '../models/my_course.dart';

class patientdetails extends StatefulWidget {
  static const routeName = '/patientdetails';
  @override
  _MyCourseDetailScreenState createState() => _MyCourseDetailScreenState();
}

class _MyCourseDetailScreenState extends State<patientdetails> {
  var _isInit = true;
  var _isAuth = false;
  var _isLoading = false;
  final MyCourse loadedCourse;
  _MyCourseDetailScreenState({@required this.loadedCourse});
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final myCourseId = ModalRoute.of(context).settings.arguments as int;

      Provider.of<MyCourses>(context, listen: false)
          .fetchCourseSections(myCourseId)
          .then((_) {
        final activeSections =
            Provider.of<MyCourses>(context, listen: false).sectionitems;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final myCourseId = ModalRoute.of(context).settings.arguments as int;
    final myLoadedCourse =
        Provider.of<MyCourses>(context, listen: false).findById(myCourseId);
    final sections =
        Provider.of<MyCourses>(context, listen: false).sectionitems;
    var lessonCount = 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: MyCourseDetailHeader(loadedCourse: myLoadedCourse),
        ),
        body: DefaultTabController(
          length: 2,
          child: MaterialApp(
            home: Scaffold(
              appBar: TabBar(
                labelColor: Colors.black,
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                tabs: [
                  Tab(
                    text: 'Personal',
                  ),
                  Tab(
                    text: 'Medical',
                  ),
                ],
              ),
              body: TabBarView(
                children: [
                  Table(
                    children: [
                      TableRow(children: [
                        Text(
                          "Contact Number",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.contact,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Email",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.email,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Emergency Contact",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.emergency,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Gender",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.gender,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Date of Birth",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.dob,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Maritial Status",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.maritial,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                    ],
                  ),
                  Table(
                    children: [
                      TableRow(children: [
                        Text(
                          "Blood Group",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.blood,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Height",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.hieght,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Weight ",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.weight,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Smoking Habits",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.smoke,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Alcohol Consumption",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.alc,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "Food Preferences",
                          textScaleFactor: 1.5,
                        ),
                        Text(
                          myLoadedCourse.fp,
                          textScaleFactor: 1.5,
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
