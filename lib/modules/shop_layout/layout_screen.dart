import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'package:untitled/Network/local/cache_helper.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/modules/cart_screen.dart';
import 'package:untitled/modules/login_screen.dart';
import 'package:untitled/modules/profile_screen.dart';

import '../../shared/component.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          drawer: Drawer(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(height: 10,),
                Text('Hey')
              ],
            ),

          ),
          floatingActionButton:!cubit.cartscreen? FloatingActionButton(
            child: Icon(
              Icons.shopping_cart_outlined,
              color: cubit.cartscreen ? Colors.white : Colors.black,
            ),
            backgroundColor: cubit.cartscreen ? color : Colors.white,
            onPressed: () {
              cubit.ChangeCartScreen();
            },
            //params
          ):null,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: buildBottomNavigationBar(cubit),
          appBar: buildAppBar(context),
          backgroundColor: Color(0xFFFDFDFD),
          body: cubit.cartscreen
              ? CartScreen()
              : cubit.screens[cubit.bottomNavIndex],
        );
      },
      listener: (context, state) {},
    );
  }

  BottomNavigationBar buildBottomNavigationBar(LayoutCubit cubit) {
    return ! cubit.cartscreen?BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: cubit.bottomNavIndex,
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.black,
      onTap: (value) {
        cubit.ChangeNavBar(value);
      },
      selectedItemColor: cubit.cartscreen ? Colors.black : color,
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(Icons.favorite_border),
            ),
            label: 'Favourite       '),
        BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Icon(CupertinoIcons.search),
            ),
            label: '         Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
    ):
    BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: cubit.bottomNavIndex,
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.black,
      onTap: (value) {
        cubit.ChangeNavBar(value);
      },
      selectedItemColor: cubit.cartscreen ? Colors.black : color,
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favourite'),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Color(0xFFF9F9F9),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: InkWell(
            onTap: (){
              if (Scaffold.of(context).isDrawerOpen) {
                Navigator.of(context).pop();
              } else {
                Scaffold.of(context).openDrawer();
              }
            },
            child: Image.asset("assets/images/icon1.png", height: 32, width: 32)),
      ),
      title: Image.asset(
        "assets/images/logo.png",
        width: 111,
        height: 31,
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen(),));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Image.asset(
              "assets/images/profile.png",
              height: 40,
              width: 40,
            ),
          ),
        )
      ],
      centerTitle: true,
    );
  }
}
