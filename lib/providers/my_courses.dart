import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import '../models/my_course.dart';
import '../constants.dart';
import '../models/course_detail.dart';
import '../models/section.dart';

class MyCourses with ChangeNotifier {
  List<MyCourse> _items = [];
  List<Section> _sectionItems = [];
  final String authToken;

  MyCourses(this.authToken, this._items);

  List<MyCourse> get items {
    return [..._items];
  }

  List<Section> get sectionitems {
    return [..._sectionItems];
  }

  int get itemCount {
    return _items.length;
  }

  MyCourse findById(int id) {
    return _items.firstWhere((myCourse) => myCourse.id == id);
  }

  Future<void> fetchMyCourses() async {
    var url =
        'http://manage.doctorjiyo.com/api/PatientsListAPI?DoctorId=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildMyCourseList(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<MyCourse> buildMyCourseList(List extractedData) {
    final List<MyCourse> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(MyCourse(
        id: courseData['PatientID'],
        patientname: courseData['PatientName'],
        thumbnail: courseData['ImgPath'],
        contact: courseData['ContactNumber'],
        email: courseData['Email'],
        gender: courseData['Gender'],
        dob: courseData['DOB'],
        blood: courseData['BloodGroup'],
        maritial: courseData['MaritalStatus'],
        hieght: courseData['Height'],
        weight: courseData['Weight'],
        emergency: courseData['EmergencyContact'],
        location: courseData['Location'],
        alc: courseData['AlcoholConsumption'],
        fp: courseData['FoodPreferences'],
        smoke: courseData['SmokingHabits'],
      ));
      // print(catData['name']);
    });
    return loadedCourses;
  }

  Future<void> fetchrecords() async {
    var url =
        'http://manage.doctorjiyo.com/api/RecordsAPI?PatientId=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildrecord(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<MyCourse> buildrecord(List extractedData) {
    final List<MyCourse> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(MyCourse(
        recordname: courseData['RecordName'],
        recordcat: courseData['RecordCatName'],
        recordnotes: courseData['Notes'],
        time: courseData['CreatedAt'],
        file: courseData['FilePath'],
      ));
      // print(catData['name']);
    });
    return loadedCourses;
  }

  Future<void> fetchpatientlist() async {
    var url =
        'http://manage.doctorjiyo.com/api/PatientsListAPI?DoctorId=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildpatientlist(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<MyCourse> buildpatientlist(List extractedData) {
    final List<MyCourse> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(MyCourse(
        recordname: courseData['PatientName'],
      ));
      // print(catData['name']);
    });
    return loadedCourses;
  }

  Future<void> fetchappoint() async {
    var url = 'http://manage.doctorjiyo.com/api/AppointmentListAPI?Patientid=1';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildappoint(extractedData);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<MyCourse> buildappoint(List extractedData) {
    final List<MyCourse> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(MyCourse(
        recordname: courseData['Tokens'][loadedCourses.length]['BookingDate'],
        recordcat: courseData['Tokens'][loadedCourses.length]['EstimateTime'],
        recordnotes: courseData['Tokens'][loadedCourses.length]
            ['DispensaryName'],
        time: courseData['CreatedAt'],
        file: courseData['FilePath'],
      ));
      // print(catData['name']);
    });
    return loadedCourses;
  }

  Future<void> fetchCourseSections(int courseId) async {
    var url =
        'http://manage.doctorjiyo.com/api/PrescriptionsAPI?PatientId=$courseId';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }

      final List<Section> loadedSections = [];
      extractedData.forEach((sectionData) {
        loadedSections.add(Section(
          id: sectionData['PrescriptionID'],
          numberOfCompletedLessons: sectionData['PatientName'],
          title: sectionData['DoctorName'],
          prestit: sectionData['PrescriptionDate'],
          lessonCounterEnds: sectionData['Diagnosis '],
        ));
      });
      _sectionItems = loadedSections;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
