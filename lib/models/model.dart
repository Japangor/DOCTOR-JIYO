import 'package:flutter/foundation.dart';

class fetchdataa {
  int id;
  String patientname;
  String thumbnail;
  String contact;
  String email;
  String gender;
  String dob;
  String blood;
  String maritial;
  String hieght;
  String weight;
  String emergency;
  String location;
  String smoke;
  String alc;
  String fp;
  String prestit;
  String recordname;
  String recordid;
  String recordnotes;
  String recordcat;
  String time;
  String file;

  fetchdataa({
    @required this.id,
    @required this.patientname,
    @required this.thumbnail,
    @required this.contact,
    @required this.email,
    @required this.gender,
    @required this.dob,
    @required this.blood,
    @required this.maritial,
    @required this.hieght,
    @required this.weight,
    @required this.emergency,
    @required this.location,
    @required this.smoke,
    @required this.alc,
    @required this.fp,
    @required this.prestit,
    @required this.recordname,
    @required this.recordid,
    @required this.recordnotes,
    @required this.recordcat,
    @required this.time,
    @required this.file,
  });
}

class appointtt {
  List<Tokens> tokens;
  List<Slots> slots;

  appointtt({this.tokens, this.slots});

  appointtt.fromJson(Map<String, dynamic> json) {
    if (json['Tokens'] != null) {
      tokens = new List<Tokens>();
      json['Tokens'].forEach((v) {
        tokens.add(new Tokens.fromJson(v));
      });
    }
    if (json['Slots'] != null) {
      slots = new List<Slots>();
      json['Slots'].forEach((v) {
        slots.add(new Slots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokens != null) {
      data['Tokens'] = this.tokens.map((v) => v.toJson()).toList();
    }
    if (this.slots != null) {
      data['Slots'] = this.slots.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tokens {
  int tokenBookingID;
  String bookingDate;
  String purposeOfVisit;
  int tokenNo;
  String estimateTime;
  String dispensaryName;
  String dispensaryLocation;
  String dispensaryLat;
  String dispensaryLong;
  String dispensaryTiming;
  String doctorName;
  int patientID;
  String patientName;

  Tokens(
      {this.tokenBookingID,
      this.bookingDate,
      this.purposeOfVisit,
      this.tokenNo,
      this.estimateTime,
      this.dispensaryName,
      this.dispensaryLocation,
      this.dispensaryLat,
      this.dispensaryLong,
      this.dispensaryTiming,
      this.doctorName,
      this.patientID,
      this.patientName});

  Tokens.fromJson(Map<String, dynamic> json) {
    tokenBookingID = json['TokenBookingID'];
    bookingDate = json['BookingDate'];
    purposeOfVisit = json['PurposeOfVisit'];
    tokenNo = json['TokenNo'];
    estimateTime = json['EstimateTime'];
    dispensaryName = json['DispensaryName'];
    dispensaryLocation = json['DispensaryLocation'];
    dispensaryLat = json['DispensaryLat'];
    dispensaryLong = json['DispensaryLong'];
    dispensaryTiming = json['DispensaryTiming'];
    doctorName = json['DoctorName'];
    patientID = json['PatientID'];
    patientName = json['PatientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TokenBookingID'] = this.tokenBookingID;
    data['BookingDate'] = this.bookingDate;
    data['PurposeOfVisit'] = this.purposeOfVisit;
    data['TokenNo'] = this.tokenNo;
    data['EstimateTime'] = this.estimateTime;
    data['DispensaryName'] = this.dispensaryName;
    data['DispensaryLocation'] = this.dispensaryLocation;
    data['DispensaryLat'] = this.dispensaryLat;
    data['DispensaryLong'] = this.dispensaryLong;
    data['DispensaryTiming'] = this.dispensaryTiming;
    data['DoctorName'] = this.doctorName;
    data['PatientID'] = this.patientID;
    data['PatientName'] = this.patientName;
    return data;
  }
}

class Slots {
  int slotBookingID;
  String bookingDate;
  String purposeOfVisit;
  String slotTime;
  String dispensaryName;
  String dispensaryLocation;
  String dispensaryLat;
  String dispensaryLong;
  String dispensaryTiming;
  String doctorName;
  int patientID;
  String patientName;

  Slots(
      {this.slotBookingID,
      this.bookingDate,
      this.purposeOfVisit,
      this.slotTime,
      this.dispensaryName,
      this.dispensaryLocation,
      this.dispensaryLat,
      this.dispensaryLong,
      this.dispensaryTiming,
      this.doctorName,
      this.patientID,
      this.patientName});

  Slots.fromJson(Map<String, dynamic> json) {
    slotBookingID = json['SlotBookingID'];
    bookingDate = json['BookingDate'];
    purposeOfVisit = json['PurposeOfVisit'];
    slotTime = json['SlotTime'];
    dispensaryName = json['DispensaryName'];
    dispensaryLocation = json['DispensaryLocation'];
    dispensaryLat = json['DispensaryLat'];
    dispensaryLong = json['DispensaryLong'];
    dispensaryTiming = json['DispensaryTiming'];
    doctorName = json['DoctorName'];
    patientID = json['PatientID'];
    patientName = json['PatientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SlotBookingID'] = this.slotBookingID;
    data['BookingDate'] = this.bookingDate;
    data['PurposeOfVisit'] = this.purposeOfVisit;
    data['SlotTime'] = this.slotTime;
    data['DispensaryName'] = this.dispensaryName;
    data['DispensaryLocation'] = this.dispensaryLocation;
    data['DispensaryLat'] = this.dispensaryLat;
    data['DispensaryLong'] = this.dispensaryLong;
    data['DispensaryTiming'] = this.dispensaryTiming;
    data['DoctorName'] = this.doctorName;
    data['PatientID'] = this.patientID;
    data['PatientName'] = this.patientName;
    return data;
  }
}
