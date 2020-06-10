import 'package:coupon_college/route/route_detail.dart';
import 'package:coupon_college/route/route_home.dart';
import 'package:coupon_college/route/route_login.dart';
import 'package:coupon_college/route/route_profile.dart';
import 'package:coupon_college/route/route_scan.dart';
import 'package:coupon_college/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BuildContext context;

  MyApp(){
    _firebaseMessaging.getToken().then((value) => print(value));
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: route_login,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case route_home:
            final String value = settings.arguments;
            return MaterialPageRoute(builder: (ctx) => HomeScreen(id: value));
          case route_login:
            return MaterialPageRoute(builder: (ctx) => LoginScreen());
          case route_scan:
            return MaterialPageRoute(builder: (ctx) => ScanScreen());
          case route_profile:
            final String value = settings.arguments;
            return MaterialPageRoute(builder: (ctx) => ProfileScreen(id:value));
          case route_detail:
            final Invitation value = settings.arguments;
            return MaterialPageRoute(builder: (ctx) => DetailScreen(value));
          default:
            return MaterialPageRoute(builder: (ctx) => LoginScreen());
        }
      },
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.white,
        disabledColor: Colors.black,
      ),
    );
  }
}
