import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/courses.dart';
import '../constants.dart';
import '../screens/course_detail_screen.dart';
import '../models/course.dart';
import '../widgets/custom_text.dart';
import '../models/common_functions.dart';
import 'package:http/http.dart' as http;

class WishlistGrid extends StatelessWidget {
  final Course course;

  WishlistGrid({
    @required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => second(
                text: course.PrescriptionID,
              ),
            ));
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
                      child: Customtext(
                        text: course.prestitle.length < 38
                            ? course.prestitle
                            : course.prestitle.substring(0, 37),
                        fontSize: 14,
                        colors: kTextLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),
                    Container(
                      height: 42,
                      child: Text(
                        'Patient Name: ' + course.prespatname,
                        style: TextStyle(fontSize: 14, color: kTextLightColor),
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Text(
                        'Doctor Name: ' + course.doctorname,
                        style: TextStyle(fontSize: 14, color: kTextLightColor),
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Text(
                        'Diagnosis: ' + course.Diagnosis,
                        style: TextStyle(fontSize: 14, color: kTextLightColor),
                      ),
                    ),
                    Container(
                      height: 42,
                      child: Text(
                        'Date : ' + course.presdate,
                        style: TextStyle(fontSize: 14, color: kTextLightColor),
                      ),
                    ),
                    // PopupMenuButton(
                    //     onSelected: (int courseId) {
                    //       Provider.of<Courses>(context, listen: false)
                    //           .toggleWishlist(courseId, true)
                    //           .then((_) => CommonFunctions.showSuccessToast(
                    //               'Removed from wishlist.'));
                    //     },
                    //     icon: Icon(
                    //       Icons.more_horiz,
                    //     ),
                    //     itemBuilder: (_) => [
                    //           PopupMenuItem(
                    //             child: Text('Remove from wishlist'),
                    //             value: course.id,
                    //           ),
                    //         ]),
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

class second extends StatefulWidget {
  final int text;

  second({Key key, @required this.text}) : super(key: key);

  @override
  HomePageState createState() => HomePageState(text);
}

class HomePageState extends State<second> {
  int text;
  HomePageState(this.text);
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://manage.doctorjiyo.com/api/PrescriptionDetailsAPI?PrescriptionID=$text"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text.toString()),
      ),
      body: data == null
          ? LinearProgressIndicator()
          : ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.blue[50],
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
                              padding: EdgeInsets.all(1),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[],
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' + data[index]["DrugName"],
                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' + data[index]["Dosage"],
                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' + data[index]["Qty"],
                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' +
                                          data[index]["FormulationType"],
                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' + data[index]["Instruction"],
                                    ),
                                  ),
                                  Container(
                                    height: 42,
                                    child: Text(
                                      'Drug Name:' + data[index]["NoOfDays"],
                                    ),
                                  ),

                                  // PopupMenuButton(
                                  //     onSelected: (int courseId) {
                                  //       Provider.of<Courses>(context, listen: false)
                                  //           .toggleWishlist(courseId, true)
                                  //           .then((_) => CommonFunctions.showSuccessToast(
                                  //               'Removed from wishlist.'));
                                  //     },
                                  //     icon: Icon(
                                  //       Icons.more_horiz,
                                  //     ),
                                  //     itemBuilder: (_) => [
                                  //           PopupMenuItem(
                                  //             child: Text('Remove from wishlist'),
                                  //             value: course.id,
                                  //           ),
                                  //         ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
