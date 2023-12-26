import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

ThemeData theme=ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
    ),
    //primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:backgroundColor,
          statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor:backgroundColor,
      elevation: 0,

    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedItemColor: Color(0xFFF83758),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black
    )
);

