import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants.dart';

ThemeData theme=ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black
        )
    ),
    //primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:backgroundColor,
          statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor:backgroundColor,
      elevation: 0,

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedItemColor: Color(0xFFF83758),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black
    )
);

ThemeData darkTheme=ThemeData(

    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )
    ),
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor:HexColor('333739'),
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white,
            fontSize: 20,fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white,size: 30)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 30,
        selectedItemColor: Colors.blue,
        backgroundColor:HexColor('333739'),
        unselectedItemColor: Colors.white

    )
);