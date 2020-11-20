import 'package:flutter/foundation.dart';

class Prescription {
  int PrescriptionID;
  String prespatname;
  String doctorname;
  String presdate;
  String instructor;
  String prestitle;

  String Diagnosis;

  Prescription({
    @required this.PrescriptionID,
    @required this.prespatname,
    @required this.presdate,
    @required this.doctorname,
    @required this.instructor,
    @required this.prestitle,
    @required this.Diagnosis,
  });
}
