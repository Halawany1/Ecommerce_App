import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/Network/local/cache_helper.dart';
import 'package:untitled/bloc/splashCubit/splash_cubit.dart';
import 'package:untitled/modules/login_screen.dart';

import '../constants.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  void OnSubmit(context){
    CacheHelper.SaveData(key: onboardingkey, value: true).then((value) {
      if(value!){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:(context) => LoginScreen(), ));
      }
    });

  }
  Widget build(BuildContext context) {

    var splashController=PageController();
    return BlocConsumer<SplashCubit,SplashState>(
      builder: (context, state) {
        var cubit=context.read<SplashCubit>();
        return Scaffold(
          appBar: buildAppBar(cubit.index,context),
          body: Column(
            children: [
              Container(
                height: 660,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: splashController,
                  onPageChanged: (value) {
                    if(value==text.length-1){
                      cubit.last=true;
                    }else{
                      cubit.last=false;
                    }
                    cubit.LastSpalshScreen(value);
                    print(cubit.last);
                  },
                  itemBuilder: (context, index) =>
                      buildsplash(index) ,
                  itemCount: text.length,),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:cubit.index>0? () {
                        splashController.previousPage(
                            duration: Duration( milliseconds: 800),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }:null,
                      child: Text("Prev",style: TextStyle(
                        fontSize: 18,
                        color: cubit.index>0?Color(0xFFC4C4C4):Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Spacer(),
                    SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 5,
                        dotWidth: 10,
                        activeDotColor: Colors.black
                      ),
                      controller: splashController,
                        count: text.length,
                    ),
                    Spacer(),
                    TextButton(onPressed: () {
                      if(cubit.last==true){
                        OnSubmit(context);
                      }else {
                        splashController.nextPage(
                            duration: Duration(
                                milliseconds: 800
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }, child: Text(cubit.last?"Get Started":"Next",style: TextStyle(
                      fontSize: 18,
                      color: color
                    ),))

                  ],
                ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {

      },
    );
  }

  Widget buildsplash(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Container(
            width:double.infinity ,
              height:300 ,
              child: Image.asset("assets/images/onboarding${index+1}.png")),
          SizedBox(height: 20,),
          Text(text[index],style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24
          ),),
          SizedBox(height: 10,),
          Text("Amet minim mollit non deserunt ullamco est\n "
              "\t\t\tsit aliqua dolor do amet sint."
              " Velit officia\n"
              " \t\t\t\t\t\t\t\t\t\tconsequat duis enim velit mollit.",style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Color(0xFFA8A8A9)
          ),)
        ],
      ),
    );
  }

  AppBar buildAppBar(int changescreen,context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
            width: 60,
            child: IconButton(onPressed: () {
              OnSubmit(context);
            }, icon:Text(
              "Skip",
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),
            )),
          ),
        )
      ],
      leading:Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Row(
          children: [
            Text("${changescreen+1}",
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )
            ),
            Text("/3",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ),
    );
  }


}
List text =[
  "Choose Products",
  "Make Payment",
  "Get Your Order"
];