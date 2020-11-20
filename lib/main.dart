import 'package:doctor/screens/addrecord.dart';
import 'package:doctor/screens/intro.dart';
import 'package:doctor/screens/patientmain.dart';
import 'package:doctor/screens/patientdetails.dart';
import 'package:doctor/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/prescription.dart';
import './screens/auth_screen.dart';
import './screens/login_screen.dart';
import './constants.dart';
import './screens/webview_screen.dart';
import './screens/doctormain.dart';
import './screens/courses_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/edit_password_screen.dart';
import './screens/my_course_detail_screen.dart';
import './screens/webview_screen_iframe.dart';
import './screens/temp_view_screen.dart';
import './providers/fetch.dart';
import 'package:doctor/screens/attendantmain.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   statusBarBrightness: Brightness.light,
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, prescription>(
          create: (ctx) => prescription(null, [], []),
          update: (ctx, auth, prevoiusCourses) => prescription(
            auth.token,
            prevoiusCourses == null ? [] : prevoiusCourses.items,
            prevoiusCourses == null ? [] : prevoiusCourses.topItems,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, fetchdata>(
          create: (ctx) => fetchdata(null, []),
          update: (ctx, auth, previousMyCourses) => fetchdata(
            auth.token,
            previousMyCourses == null ? [] : previousMyCourses.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                  title: 'DOCTOR JIYO',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    accentColor: kDarkButtonBg,
                    fontFamily: 'google_sans',
                  ),
                  debugShowCheckedModeBanner: false,
                  home: auth.isAuth
                      ? splash()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : splash(),
                        ),
                  routes: {
                    '/home': (ctx) => TabsScreen(),
                    '/patient': (ctx) => patient(),
                    '/attendant': (ctx) => attendant(),
                    '/splash': (ctx) => splash(),
                    '/addrecord': (ctx) => addrecord(),
                    '/intro': (ctx) => OnboardingScreen(),
                    AuthScreen.routeName: (ctx) => AuthScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    WebviewScreen.routeName: (ctx) => WebviewScreen(),
                    WebviewScreenIframe.routeName: (ctx) =>
                        WebviewScreenIframe(),
                    CoursesScreen.routeName: (ctx) => CoursesScreen(),
                    EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
                    EditPasswordScreen.routeName: (ctx) => EditPasswordScreen(),
                    patientdetails.routeName: (ctx) => patientdetails(),
                    TempViewScreen.routeName: (ctx) => TempViewScreen(),
                  })),
    );
  }
}
