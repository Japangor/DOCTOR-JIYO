import 'package:flutter/foundation.dart';

class Course {
  int PrescriptionID;
  String prespatname;
  String doctorname;
  String presdate;
  String instructor;
  String prestitle;

  String Diagnosis;

  Course({
    @required this.PrescriptionID,
    @required this.prespatname,
    @required this.presdate,
    @required this.doctorname,
    @required this.instructor,
    @required this.prestitle,
    @required this.Diagnosis,
  });
}
