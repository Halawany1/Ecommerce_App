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
  void onSubmit(context){
    CacheHelper.saveData(key: onboardingkey, value: true).then((value) {
      if(value!){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:(context) => const LoginScreen(), ));
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    var splashController=PageController();
    return BlocConsumer<SplashCubit,SplashState>(
      builder: (context, state) {
        var cubit=context.read<SplashCubit>();
        return Scaffold(
          appBar: buildAppBar(cubit.index,context),
          body: Column(
            children: [
              SizedBox(
                height: 660,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
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
                      buildSplash(index) ,
                  itemCount: text.length,),
              ),
              Padding(
                padding:const  EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:cubit.index>0? () {
                        splashController.previousPage(
                            duration: const Duration( milliseconds: 800),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }:null,
                      child: Text("Prev",style: TextStyle(
                        fontSize: 18,
                        color: cubit.index>0?const Color(0xFFC4C4C4):Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    const Spacer(),
                     SmoothPageIndicator(
                      effect:const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 5,
                        dotWidth: 10,
                        activeDotColor: Colors.black
                      ),
                      controller: splashController,
                        count: text.length,
                    ),
                    const Spacer(),
                    TextButton(onPressed: () {
                      if(cubit.last==true){
                        onSubmit(context);
                      }else {
                        splashController.nextPage(
                            duration: const Duration(
                                milliseconds: 800
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }, child: Text(cubit.last?"Get Started":"Next",
                      style:const TextStyle(
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

  Widget buildSplash(int index) {
    return Padding(
      padding:  EdgeInsets.only(top: 80),
      child: Column(
        children: [
          SizedBox(
            width:double.infinity ,
              height:300 ,
              child: Image.asset("assets/images/onboarding${index+1}.png")),
          const SizedBox(height: 20,),
          Text(text[index],style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24
          ),),
          const SizedBox(height: 10,),
          const Text("Amet minim mollit non deserunt ullamco est\n "
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
          child: SizedBox(
            width: 60,
            child: IconButton(onPressed: () {
              onSubmit(context);
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
        padding:const  EdgeInsets.only(left: 18),
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