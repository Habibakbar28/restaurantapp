import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const String account = 'Setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0.0,
        title: Text(account),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.yellow],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              )
          ),
        ),
      ),
    );
  }
}
