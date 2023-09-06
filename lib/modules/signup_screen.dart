import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/loginAuthenticationCubit/user_cubit.dart';
import 'package:untitled/modules/shop_layout/layout_screen.dart';
import 'package:untitled/shared/component.dart';

import '../Network/local/cache_helper.dart';
import '../constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is SignUpSuccessState){
          if(state.signupmodel.status==true){
            print(state.signupmodel.data!.token);
            print(state.signupmodel.message);
            CacheHelper.SaveData(key: tokenkey, value:state.signupmodel.data!.token).
            then((value) {
              if(value!) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LayoutScreen(),));
              }
            });
          }else{
            print(state.signupmodel.message);
            ShowToast(message: "${state.signupmodel.message}",
                state:ToastState.ERROR );
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<UserCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.only( left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Create an\naccount",
                          style: GoogleFonts.alice(
                              fontSize: 45, fontWeight: FontWeight.w800)),
                      SizedBox(
                        height: 30,
                      ),
                      BuildFormField(
                          login: true,
                          signUpcubit: cubit,
                          hinttext: "User Name",
                          prefixIcon: Icons.person,
                          Controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "name must be found";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      BuildFormField(
                          login: true,
                          signUpcubit: cubit,
                          hinttext: "Email",
                          prefixIcon: Icons.email,
                          Controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email must be found";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      BuildFormField(
                          login: true,
                          signUpcubit: cubit,
                          visibility: () {
                            cubit.ChangePasswordVisibility();
                          },
                          hinttext: "Password",
                          password: true,
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.passwordVisibility
                              ? Icons.visibility
                              : Icons.visibility_off,
                          Controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password must be found";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      BuildFormField(
                          login: true,
                          signUpcubit: cubit,
                          hinttext: "Phone",
                          prefixIcon: Icons.phone,
                          Controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone must be found";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        builder: (context) {
                          return BuildElevatedButton(
                              text: "Create Account",
                              onpress: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.UserSignUp(
                                    name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              });
                        },
                        condition:state is! LoadingSignUpState ,
                        fallback: (context) => BuildElevatedButton(
                          loading: false,
                            onpress: () {
                            }
                            ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "- OR Continue with -",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFF575757),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildCircleIcons(image: "google.png"),
                          SizedBox(width: 12,),
                          BuildCircleIcons(image: "apple.png"),
                          SizedBox(width: 12,),
                          BuildCircleIcons(image: "facebook.png"),
                        ],),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I Already Have an Account",
                            style: GoogleFonts.montserrat(
                                color:Color(0xFF575757),
                                fontWeight: FontWeight.w500
                            ),),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text("Login",

                              style: GoogleFonts.montserrat(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  color:color,
                                  fontWeight: FontWeight.w600
                              ),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
