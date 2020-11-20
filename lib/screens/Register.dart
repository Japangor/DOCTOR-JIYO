import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../constants.dart';
import '../widgets/custom_text.dart';
import 'dart:io';
import '../models/common_functions.dart';

class register extends StatefulWidget {
  static const routeName = '/register';
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<register> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  Map<String, String> _passwordData = {
    'PatientName': '',
    'ContactNumber': '',
    'Email': '',
    'Password': ''
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
      await Provider.of<Auth>(context, listen: false).register(
          _passwordData['PatientName'],
          _passwordData['ContactNumber'],
          _passwordData['Email'],
          _passwordData['Password']);

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
                  text: 'Register',
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
                              _passwordData['PatientName'] = value;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Number',
                              Icons.vpn_key,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Can not be empty';
                              }
                            },
                            onSaved: (value) {
                              _passwordData['ContactNumber'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Email',
                              Icons.vpn_key,
                            ),
                            controller: _passwordController,
                            onSaved: (value) {
                              _passwordData['Email'] = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 16),
                            decoration: getInputDecoration(
                              'Password',
                              Icons.vpn_key,
                            ),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Password is too short!';
                              }
                            },
                            onSaved: (value) {
                              _passwordData['Password'] = value;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: _submit,
                              child: Text(
                                'Register',
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
