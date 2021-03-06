import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../constants.dart';
import '../widgets/custom_text.dart';
import 'dart:io';
import '../models/common_functions.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class addrecord extends StatefulWidget {
  static const routeName = '/addrecord';
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

class _EditPasswordScreenState extends State<addrecord> {
  String _filePath;
  File _image;
  void open_gallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    print(_image);
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  Map<String, String> _passwordData = {
    'RecordName': '',
    'Notes': '',
    'RecordCatName': '',
    'PrescriptionID': '',
    'CreatedAt': '',
    'FilePath': ''
  };
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).uploadrecord(
        _passwordData['RecordName'],
        _passwordData['Notes'],
        _passwordData['RecordCatName'],
        _passwordData['PrescriptionID'],
        _passwordData['CreatedAt'],
        _passwordData['FilePath'],
      );

      CommonFunctions.showSuccessToast('Password updated Successfully');
    } catch (error) {
      print(error);
      const errorMsg = 'Password Update failed!';
      CommonFunctions.showErrorDialog(errorMsg, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      enabledBorder: kDefaultInputBorder,
      focusedBorder: kDefaultFocusInputBorder,
      focusedErrorBorder: kDefaultFocusErrorBorder,
      errorBorder: kDefaultFocusErrorBorder,
      filled: true,
      hintStyle: TextStyle(color: kFormInputColor),
      hintText: hintext,
      fillColor: Colors.white70,
      prefixIcon: Icon(
        iconData,
        color: kFormInputColor,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Customtext(
                  text: 'Update Record',
                  colors: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Name',
                              Icons.vpn_key,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Can not be empty';
                              }
                            },
                            onSaved: (value) {
                              _passwordData['RecordName'] = value;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Notes',
                              Icons.vpn_key,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Can not be empty';
                              }
                            },
                            onSaved: (value) {
                              _passwordData['Notes'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Category',
                              Icons.vpn_key,
                            ),
                            controller: _passwordController,
                            onSaved: (value) {
                              _passwordData['RecordCatName'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'PrescriptionID',
                              Icons.vpn_key,
                            ),
                            onSaved: (value) {
                              _passwordData['PrescriptionID'] = value;
                            },
                          ),
                          TextFormField(
                            initialValue: formattedDate,
                            style: TextStyle(fontSize: 16),
                            onSaved: (formattedDate) {
                              _passwordData['CreatedAt'] = formattedDate;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RaisedButton(
                            onPressed: open_gallery,
                            child: Text(
                              'Choose Image',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            color: kBlueColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            splashColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              side: BorderSide(color: kBlueColor),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: _submit,
                              child: Text(
                                'UPDATE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              color: kBlueColor,
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              splashColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                side: BorderSide(color: kBlueColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
