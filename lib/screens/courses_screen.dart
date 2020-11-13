import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/courses.dart';
import '../widgets/course_list_item.dart';

class CoursesScreen extends StatefulWidget {
  static const routeName = '/courses';
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  var _isInit = true;
  var _isLoading = false;

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

      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;

      final pageDataType = routeArgs['type'] as CoursesPageData;
      if (pageDataType == CoursesPageData.Category) {
        final categoryId = routeArgs['category_id'] as int;
      } else if (pageDataType == CoursesPageData.Search) {
        final searchQuery = routeArgs['seacrh_query'] as String;
      } else if (pageDataType == CoursesPageData.All) {
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final courseData = Provider.of<Courses>(context, listen: false).items;
    final courseCount = courseData.length;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kSecondaryColor, //change your color here
        ),
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: 32,
        ),
        backgroundColor: kBackgroundColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Showing $courseCount Courses',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return Center();
                      },
                      itemCount: courseData.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
