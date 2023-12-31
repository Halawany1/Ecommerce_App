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
              systemOverlayStyle:const SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.blue,
              iconTheme:const IconThemeData(color: Colors.white),
              title:const Text(
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
                  physics:const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCirclePhoto(),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Personal Details',
                          style: GoogleFonts.montserrat(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Name',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            context: context,
                            read: true,
                            Controller: nameController,
                            validator: null),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email Address',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            context: context,
                            read: true,
                            Controller: emailController,
                            validator: null),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            context: context,
                            read: true,
                            Controller: passwordController,
                            validator: null),
                        const  SizedBox(
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
                                          const ChangePasswordScreen(),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Phone',
                          style: GoogleFonts.montserrat(fontSize: 15),
                        ),
                        const  SizedBox(
                          height: 20,
                        ),
                        BuildFormField(
                            context: context,
                            read: true,
                            Controller: phoneController,
                            validator: null),
                        const SizedBox(
                          height: 50,
                        ),
                        BuildElevatedButton(
                            onpress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>const UpdateProfileScreen(),
                                  ));
                            },
                            text: 'Update Profile'),
                        const   SizedBox(
                          height: 20,
                        ),
                        BuildElevatedButton(
                            onpress: () {
                              CacheHelper.removeData(key: tokenkey)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>const LoginScreen(),
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
              fallback: (context) =>const Center(
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
                child:const CircleAvatar(
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
