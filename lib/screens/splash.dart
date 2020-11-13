import 'dart:async';
import 'package:doctor/screens/addrecord.dart';
import 'package:doctor/screens/auth_screen.dart';
import 'package:doctor/screens/course_detail_screen.dart';
import 'package:doctor/screens/courses_screen.dart';
import 'package:doctor/screens/edit_password_screen.dart';
import 'package:doctor/screens/edit_profile_screen.dart';
import 'package:doctor/screens/login_screen.dart';
import 'package:doctor/screens/tabs_screen.dart';
import 'package:doctor/screens/temp_view_screen.dart';
import 'package:doctor/screens/webview_screen.dart';
import 'package:doctor/screens/webview_screen_iframe.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:doctor/screens/patient.dart';
import 'package:doctor/screens/patientdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor/providers/auth.dart';
import 'package:doctor/screens/attendant.dart';

void main() {
  runApp(splash());
}

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (ctx) => TabsScreen(),
        '/patient': (ctx) => patient(),
        '/attendant': (ctx) => attendant(),
        '/splash': (ctx) => splash(),
        '/addrecord': (ctx) => addrecord(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        WebviewScreen.routeName: (ctx) => WebviewScreen(),
        WebviewScreenIframe.routeName: (ctx) => WebviewScreenIframe(),
        CoursesScreen.routeName: (ctx) => CoursesScreen(),
        CourseDetailScreen.routeName: (ctx) => CourseDetailScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        EditPasswordScreen.routeName: (ctx) => EditPasswordScreen(),
        patientdetails.routeName: (ctx) => patientdetails(),
        TempViewScreen.routeName: (ctx) => TempViewScreen(),
      },
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      routeName: '/splash',
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'DOCTOR JIO',
        textScaleFactor: 2,
      ),
      image: new Image.asset('assets/applogo.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<Auth>(context, listen: false).token2 == 'doctor') {
      return TabsScreen();
    } else if (Provider.of<Auth>(context, listen: false).token2 == 'patient') {
      return patient();
    } else if (Provider.of<Auth>(context, listen: false).token2 ==
        'attendant') {
      return attendant();
    } else {
      return LoginScreen();
    }
  }
}
