import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Network/local/cache_helper.dart';
import 'package:untitled/bloc/loginAuthenticationCubit/user_cubit.dart';
import 'package:untitled/modules/shop_layout/layout_screen.dart';
import 'package:untitled/modules/signup_screen.dart';
import 'package:untitled/shared/component.dart';

import '../constants.dart';
import 'fotgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status == true) {
            print(state.loginModel.message);
            print(state.loginModel.data!.token);
            CacheHelper.SaveData(key: tokenkey, value:state.loginModel.data!.token).then((value) {
              if(value!) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LayoutScreen(),));
              }
            });
          } else {
            print(state.loginModel.message);
            ShowToast(message: "${state.loginModel.message}",
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<UserCubit>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.only(top: 40.0, left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome\nBack!",
                          style: GoogleFonts.alice(
                              fontSize: 45, fontWeight: FontWeight.w800)),
                      SizedBox(
                        height: 50,
                      ),
                      BuildFormField(
                          cubit: cubit,
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
                        height: 30,
                      ),
                      BuildFormField(
                          cubit: cubit,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      ForgotPasswordScreen(),));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 14, color: color),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ConditionalBuilder(
                        builder: (context) {
                          return BuildElevatedButton(
                              text: "Login",
                              onpress: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.UserLogin(email: emailController.text,
                                      password: passwordController.text);
                                }
                              });
                        },
                        condition: state is! LoadingLoginState,
                        fallback: (context) =>
                            BuildElevatedButton(
                                loading: false,
                                onpress: () {
                                }),
                      ),
                      SizedBox(
                        height: 60,
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
                          Text("Create An Account",
                            style: GoogleFonts.montserrat(
                                color: Color(0xFF575757),
                                fontWeight: FontWeight.w500
                            ),),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: () {
                              emailController.clear();
                              passwordController.clear();
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),));
                            },
                            child: Text("Sign Up",

                              style: GoogleFonts.montserrat(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  color: color,
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
