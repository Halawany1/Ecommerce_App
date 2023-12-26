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
import 'package:untitled/shared/component.dart';

import '../Network/end_points.dart';
import '../constants.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool data=false;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is SuccessUpdateProfileDataState){
          if(state.userModel.status==true){
            Navigator.pop(context);
            ShowToast(message: state.userModel.message!, state: ToastState.SUCCESS);
          }else{
            ShowToast(message: state.userModel.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<UserCubit>();
        return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.blue,
              iconTheme:const IconThemeData(color: Colors.white),
              title:const Text(
                "Update Profile",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) {
                if(!data) {
                  emailController.text = cubit.userModel!.data!.email!;
                  nameController.text = cubit.userModel!.data!.name!;
                  phoneController.text = cubit.userModel!.data!.phone!;
                }
                passwordController.text = '************';
                data=true;
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildCirclePhoto(),
                          const SizedBox(
                            height: 40,
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
                            prefixIcon: Icons.person,
                              Controller: nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name must be Found";
                                }
                                return null;
                              }),
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
                              prefixIcon: Icons.email,
                              Controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email must be Found";
                                }
                                return null;
                              }),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Phone',
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BuildFormField(
                              context: context,
                              prefixIcon: Icons.phone,
                              Controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Phone must be Found";
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 50,
                          ),
                          state is LoadingUpdateProfileDataState?
                          BuildElevatedButton(
                              loading: false,
                              onpress: () {
                          },):
                          BuildElevatedButton(
                              onpress: () {
                            if (formKey.currentState!.validate()) {
                              cubit.UpdateProfileData(name: nameController.text,
                                  phone: phoneController.text,email: emailController.text);
                            }
                          },text: "Save"),

                        ],
                      ),
                    ),
                  ),
                );
              },
              fallback: (context) =>
                  Center(
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
