import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import 'dart:convert';
import '../models/prescription.dart';
import '../constants.dart';

class prescription with ChangeNotifier {
  List<Prescription> _items = [];
  List<Prescription> _topItems = [];
  final String authToken;

  prescription(this.authToken, this._items, this._topItems);

  List<Prescription> get items {
    return [..._items];
  }

  List<Prescription> get topItems {
    return [..._topItems];
  }

  int get itemCount {
    return _items.length;
  }

  Prescription findById(int id) {
    // return _topItems.firstWhere((course) => course.id == id);
  }

  Future<void> fetchprescription() async {
    var url =
        'http://manage.doctorjiyo.com/api/PrescriptionsAPI?PatientId=$authToken';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List;
      if (extractedData == null) {
        return;
      }
      // print(extractedData);
      _items = buildpreslist(extractedData);
      print(_items);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  List<Prescription> buildpreslist(List extractedData) {
    final List<Prescription> loadedCourses = [];
    extractedData.forEach((courseData) {
      loadedCourses.add(Prescription(
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
}
