import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import '../models/course.dart';
import '../constants.dart';
import '../models/course_detail.dart';
import '../models/section.dart';

class Courses with ChangeNotifier {
  List<Course> _items = [];
  List<Course> _topItems = [];
  List<CourseDetail> _courseDetailsitems = [];
  final String authToken;

  Courses(this.authToken, this._items, this._topItems);

  List<Course> get items {
    return [..._items];
  }

  CourseDetail get getCourseDetail {
    return _courseDetailsitems.first;
  }

  List<Course> get topItems {
    return [..._topItems];
  }

  int get itemCount {
    return _items.length;
  }

  Course findById(int id) {
    // return _topItems.firstWhere((course) => course.id == id);
  }

  Future<void> fetchMyWishlist() async {
    var url =
        'http://manage.doctorjiyo.com/api/PrescriptionsAPI?PatientId=$authToken';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildCourseList(extractedData);
      print(_items);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Course> buildCourseList(List extractedData) {
    final List<Course> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(Course(
        PrescriptionID: (courseData['PrescriptionID']),
        prestitle: courseData['PrescriptionTitle'],
        prespatname: courseData['PatientName'],
        doctorname: courseData['DoctorName'],
        presdate: courseData['PrescriptionDate'],
        Diagnosis: courseData['Diagnosis'],
      ));
      // print(catData['name']);
    });
    return loadedCourses;
  }

  Future<void> fetchCourseDetailById(int courseId) async {
    var url =
        'http://manage.doctorjiyo.com/api/PrescriptionDetailsAPI?PrescriptionID=$courseId';

    if (authToken != null) {
      url = BASE_URL +
          '/api/course_details_by_id?auth_token=$authToken&course_id=$courseId';
    }

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }

      final List<CourseDetail> loadedCourseDetails = [];
      extractedData.forEach((courseData) {
        loadedCourseDetails.add(CourseDetail(
          courseId: int.parse(courseData['id']),
          courseIncludes:
              (courseData['includes'] as List<dynamic>).cast<String>(),
          courseRequirements:
              (courseData['requirements'] as List<dynamic>).cast<String>(),
          courseOutcomes:
              (courseData['outcomes'] as List<dynamic>).cast<String>(),
          isWishlisted: courseData['is_wishlisted'],
          isPurchased: (courseData['is_purchased'] is int)
              ? courseData['is_purchased'] == 1
                  ? true
                  : false
              : courseData['is_purchased'],
          mSection:
              buildCourseSections(courseData['sections'] as List<dynamic>),
        ));
      });
      // print(loadedCourseDetails.first.courseOutcomes.last);
      // _items = buildCourseList(extractedData);
      _courseDetailsitems = loadedCourseDetails;
      // _courseDetail = loadedCourseDetails.first;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Section> buildCourseSections(List extractedSections) {
    final List<Section> loadedSections = [];

    extractedSections.forEach((sectionData) {
      loadedSections.add(Section(
        id: int.parse(sectionData['id']),
        numberOfCompletedLessons: sectionData['completed_lesson_number'],
        title: sectionData['title'],
        lessonCounterEnds: sectionData['lesson_counter_ends'],
      ));
    });
    // print(loadedSections.first.title);
    return loadedSections;
  }
}
