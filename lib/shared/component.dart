

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';


import '../bloc/loginAuthenticationCubit/user_cubit.dart';
import '../constants.dart';

Widget BuildFormField(
{
   String ?hinttext,
   IconData ?prefixIcon,
  IconData ?suffixIcon,
  required TextEditingController Controller,
  required  String? Function(String?)? validator,
    void Function(String value)? ontap,
  required context,
 VoidCallback ?visibility,
  bool password=false,
  bool change=true,
  LayoutCubit ?layoutCubit,
  UserCubit ?cubit,
  UserCubit ?signUpcubit,
  bool search=false,
  bool login=false,
  bool read=false,
}
    ){
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: TextFormField(
      readOnly: read,
      onFieldSubmitted:ontap,
      validator:validator ,
      obscureText:change?(password?(!login?!cubit!.passwordVisibility:!signUpcubit!.passwordVisibility):false):true,
      controller:Controller ,
      decoration: InputDecoration(
        focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color)
        ) ,
       errorBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12),
         borderSide: BorderSide(color: color)
       ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
          hintText: hinttext,
          suffixIcon:InkWell(
              onTap: visibility,
              child: Icon(suffixIcon,color: Color(0xFF626262),)) ,
          prefixIcon:!read ?Icon(prefixIcon,color: Color(0xFF626262),):null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA8A8A9)),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: !read,
          fillColor: Color(0xFFF3F3F3),
          border: OutlineInputBorder()
      ),
    ),
  );
}

Widget BuildElevatedButton({
   String ?text,
   VoidCallback ?onpress,
  double textsize=20,
  bool loading=true,
  double width=double.infinity,
  double height=55
}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          maximumSize: Size(width, height),
          backgroundColor:color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          )
      ),
      onPressed:onpress
      , child: loading?Text(text!,
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: textsize,
        fontWeight: FontWeight.w600,
      )):SizedBox(
    width: 30,
        height: 30,
        child: Center(
        child: CircularProgressIndicator(color: Colors.white,)),
      ));
}

Widget BuildCircleIcons(
{
  required String image,
}
    ){
  return Container(
    width: 55,
    height: 55,
    child: Image.asset("assets/images/$image"),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFCF3F6),
        border: Border.all(color:color)
    ),
  );
}


void ShowToast({
  required String message,
  required ToastState state
}){
   Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: ChooseToastState(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastState{SUCCESS,ERROR,WARNING}

Color ChooseToastState(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS:
      color=Colors.green;
      break;
    case ToastState.ERROR:
      color=Colors.red;
      break;
    case ToastState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

Widget BuildSettingsContainer({
  required IconData icon,
  required String text,
}){
  return  Material(
    elevation: 5,
    child: Container(
      color: Colors.blue.withOpacity(0.6),
      height: 65,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(text,style: GoogleFonts.montserrat(
                fontSize: 20
            ),),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25,
              color: Colors.black45,
            )
          ],
        ),
      ),
    ),
  );
}