import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Network/local/cache_helper.dart';
import 'package:untitled/bloc/loginAuthenticationCubit/user_cubit.dart';
import 'package:untitled/modules/change_password_screen.dart';
import 'package:untitled/modules/login_screen.dart';
import 'package:untitled/modules/upadate_profile_screen.dart';
import 'package:untitled/shared/component.dart';

import '../Network/end_points.dart';
import '../constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<UserCubit>();

        return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) {
                emailController.text = cubit.userModel!.data!.email!;
                nameController.text = cubit.userModel!.data!.name!;
                phoneController.text = cubit.userModel!.data!.phone!;
                passwordController.text = '************';
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCirclePhoto(),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Personal Details',
                          style: GoogleFonts.montserrat(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Name',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            read: true,
                            Controller: nameController,
                            validator: null),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email Address',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            read: true,
                            Controller: emailController,
                            validator: null),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            read: true,
                            Controller: passwordController,
                            validator: null),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordScreen(),
                                    ));
                              },
                              child: Text(
                                'Change Password',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: color,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            read: true,
                            Controller: phoneController,
                            validator: null),
                        SizedBox(
                          height: 50,
                        ),
                        BuildElevatedButton(
                            onpress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProfileScreen(),
                                  ));
                            },
                            text: 'Update Profile'),
                        SizedBox(
                          height: 20,
                        ),
                        BuildElevatedButton(
                            onpress: () {
                              CacheHelper.RemoveData(key: tokenkey)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ));
                                }
                              });
                            },
                            text: 'Sign Out')
                      ],
                    ),
                  ),
                );
              },
              fallback: (context) => Center(
                  child: CircularProgressIndicator(
                color: color,
              )),
            ));
      },
    );
  }

  Row buildCirclePhoto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white)),
                child: CircleAvatar(
                  radius: 16,
                  child: Icon(Icons.edit),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
