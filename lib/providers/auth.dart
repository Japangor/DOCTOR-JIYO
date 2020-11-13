import 'package:doctor/screens/attendant.dart';
import 'package:doctor/screens/patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/http_exception.dart';
import '../models/user.dart';
import 'dart:async';
import '../constants.dart';
import 'dart:io';

class Auth with ChangeNotifier {
  String _token;
  String _token2;

  User _user;

  Auth();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get token2 {
    if (_token2 != null) {
      return _token2;
    }
    return null;
  }

  User get user {
    return _user;
  }

  Future<void> login(String email, String password) async {
    var url = BASE_URL + '/DoctorLoginAPI?username=$email&password=$password';
    var url2 = BASE_URL + '/PatientLoginAPI?username=$email&password=$password';
    var url3 =
        BASE_URL + '/AttendantLoginAPI?username=$email&password=$password';

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      final response2 = await http.get(url2);
      final responseData2 = json.decode(response2.body);

      final response3 = await http.get(url3);
      final responseData3 = json.decode(response3.body);

      print(responseData['success']);
      if (responseData['success'] == false &&
          responseData2['success'] == false &&
          responseData3['success'] == false) {
        throw HttpException('Auth Failed');
      }
      if (responseData['success'] == 'true') {
        _token = responseData['DoctorID'];
        _token2 = "doctor";

        final loadedUser = User(
          userId: responseData['DoctorID'],
          firstName: responseData['DoctorID'],
          lastName: responseData['DoctorID'],
          email: responseData['DoctorID'],
          role: responseData['DoctorID'],
        );

        _user = loadedUser;
        // print(_user.firstName);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'user': jsonEncode(_user),
          'role': _token2,
        });
        prefs.setString('userData', userData);
        print(userData);
      } else if (responseData2['success'] == 'true') {
        _token = responseData2['PatientID'];
        _token2 = "patient";

        final loadedUser = User(
          userId: responseData2['PatientID'],
          firstName: responseData2['PatientID'],
          lastName: responseData2['PatientID'],
          email: responseData2['PatientID'],
          role: responseData2['PatientID'],
        );

        _user = loadedUser;
        // print(_user.firstName);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'role': _token2,
          'user': jsonEncode(_user),
        });
        prefs.setString('userData', userData);
        print(userData);
      } else if (responseData3['success'] == 'true') {
        _token = responseData3['AttendantID'];
        _token2 = "attendant";

        final loadedUser = User(
          userId: responseData3['AttendantID'],
          firstName: responseData3['AttendantID'],
          lastName: responseData3['AttendantID'],
          email: responseData3['AttendantID'],
          role: responseData3['AttendantID'],
        );

        _user = loadedUser;
        // print(_user.firstName);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'role': _token2,
          'user': jsonEncode(_user),
        });
        prefs.setString('userData', userData);
        print(userData);
      }
    } catch (error) {
      throw (error);
    }
    // return _authenticate(email, password, 'verifyPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _token2 = extractedUserData['role'];

    // print(jsonDecode(extractedUserData['user']));
    Map userMap = jsonDecode(extractedUserData['user']);
    _user = User.fromJson(userMap);
    notifyListeners();

    // _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    // _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void _autoLogout() {
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    // }
    // final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    // _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> getUserInfo() async {
    var url = BASE_URL + '/PatientProfileApi?PatientID=' + _user.userId;
    try {
      if (token == null) {
        throw HttpException('No Auth User');
      }
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      _user.firstName = responseData['PatientName'];

      _user.image = responseData['ImgPath'];
      _user.facebook = responseData['PatientName'];
      _user.twitter = responseData['PatientName'];
      _user.linkedIn = responseData['PatientName'];
      _user.biography = responseData['PatientName'];

      // print(_user.image);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getUserInfo2() async {
    var url = BASE_URL + '/DoctorProfileAPI?DoctorID=' + _user.userId;
    try {
      if (token == null) {
        throw HttpException('No Auth User');
      }
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      _user.firstName = responseData['DoctorName'];

      _user.image = responseData['ImgPath'];
      _user.facebook = responseData['Qualification'];
      _user.twitter = responseData['Experience'];
      _user.linkedIn = responseData['Speciality'];
      _user.biography = responseData['Location'];
      // print(_user.image);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getUserInfo3() async {
    var url = BASE_URL + '/AttendantProfileAPI?AttendantId=' + _user.userId;
    try {
      if (token == null) {
        throw HttpException('No Auth User');
      }
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      _user.firstName = responseData['AttendantName'];

      _user.image = responseData['ImgPath'];
      _user.facebook = responseData['Qualification'];
      _user.twitter = responseData['Experience'];
      _user.linkedIn = responseData['Speciality'];
      _user.biography = responseData['Location'];
      // print(_user.image);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> userImageUpload(File image) async {
    var url = BASE_URL + '/api/upload_user_image';
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields['auth_token'] = token;

    request.files.add(http.MultipartFile(
        'file', image.readAsBytes().asStream(), image.lengthSync(),
        filename: basename(image.path)));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          final responseData = json.decode(value);
          if (responseData['status'] != 'success') {
            throw HttpException('Upload Failed');
          }
          notifyListeners();
          print(value);
        });
      }

      // final responseData = json.decode(response.body);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateUserData(User user) async {
    final url = BASE_URL + '/PatientProfileAPI?PatientId=1';

    try {
      final response = await http.post(
        url,
        body: {
          'PatientID': token,
          'PatientName': user.firstName,
          'ContactNumber': user.lastName,
          'Email': user.email,
          'Gender': user.biography,
          'DOB': user.twitter,
          'BloodGroup': user.facebook,
          'MaritalStatus': user.linkedIn,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['status'] == 'failed') {
        throw HttpException('Update Failed');
      }

      _user.firstName = responseData['PatientName'];
      _user.lastName = responseData['PatientName'];
      _user.email = responseData['Email'];
      _user.twitter = responseData['PatientName'];
      _user.linkedIn = responseData['PatientName'];
      _user.biography = responseData['PatientName'];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateUserPassword(
      String currentPassword, String newPassword) async {
    final url = BASE_URL + '/api/update_password';
    try {
      final response = await http.post(
        url,
        body: {
          'auth_token': token,
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_password': newPassword,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['status'] == 'failed') {
        throw HttpException('Password update Failed');
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> uploadrecord(String recordname, String notes,
      String priscirption, String category, String time, String file) async {
    final url = BASE_URL + '/RecordsAPI';
    try {
      final response = await http.post(
        url,
        body: {
          'PatientID': token,
          'RecordName': recordname,
          'Notes': notes,
          'PrescriptionID': priscirption,
          'RecordCatName': category,
          'FilePath': file,
          'CreatedAt': time,
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['status'] == 'failed') {
        throw HttpException('Password update Failed');
      }
    } catch (error) {
      throw (error);
    }
  }
}
