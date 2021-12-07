import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurantdetail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'data/model/restaurant_list.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.yellow
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant:
            ModalRoute.of(context)?.settings.arguments as
            Restaurant),
        SearchPage.routeName: (context) => const SearchPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          SizedBox(height: 30.0,),
          SpinKitFadingCircle(color: Colors.black,),
          SizedBox(height: 300,),
          Text('RESTAURANTnesia')
        ],
      ),
    );
  }
}
