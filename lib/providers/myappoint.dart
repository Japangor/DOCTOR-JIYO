import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import '../models/model.dart';
import '../constants.dart';
import '../models/section.dart';

class MyCourses with ChangeNotifier {
  List<fetchdataa> _items = [];
  List<Section> _sectionItems = [];
  final String authToken;

  MyCourses(this.authToken, this._items);

  List<fetchdataa> get items {
    return [..._items];
  }

  List<Section> get sectionitems {
    return [..._sectionItems];
  }

  int get itemCount {
    return _items.length;
  }

  fetchdataa findById(int id) {
    return _items.firstWhere((fetchdataa) => fetchdataa.id == id);
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

  List<fetchdataa> buildMyCourseList(List extractedData) {
    final List<fetchdataa> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(fetchdataa(
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
