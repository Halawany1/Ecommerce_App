import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/loginAuthenticationCubit/user_cubit.dart';
import 'package:untitled/shared/component.dart';

import '../Network/end_points.dart';
import '../constants.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var oldPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var formKey=GlobalKey<FormState>();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is SuccessChangePasswordDataState){
          if(state.chagePassModel.status==true) {
            Navigator.pop(context);
            ShowToast(
                message: state.chagePassModel.message!, state: ToastState.SUCCESS);
          }else{
            ShowToast(
                message: state.chagePassModel.message!, state: ToastState.ERROR);
          }
        }

      },
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
                "Change Password",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
            ),
            body:Padding(
              padding: const EdgeInsets.all(28.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Password',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    SizedBox(height: 20,),
                    BuildFormField(
                        hinttext: "*********",
                        password: true,
                        change: false,
                        prefixIcon: Icons.lock,
                        suffixIcon:  Icons.visibility_off,
                        Controller: oldPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Current Password must be found";
                          }
                          return null;
                        }),
                    SizedBox(height: 20,),
                    Text(
                      'New Password',
                      style: GoogleFonts.montserrat(fontSize: 15),
                    ),
                    SizedBox(height: 20,),
                    BuildFormField(
                        change: false,
                        hinttext: "At least 6 digit",
                        password: true,
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.visibility_off,
                        Controller: newPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "New Password must be found";
                          }
                          return null;
                        }),
                    SizedBox(height: 50,),
                    state is LoadingChangePasswordDataState?
                    BuildElevatedButton(
                      loading: false,
                        onpress: () {
                    },
                    text: 'Change Password'):BuildElevatedButton(

                        onpress: () {
                          if(formKey.currentState!.validate()){
                            cubit.ChangePasswordData(
                                currentPass: oldPasswordController.text,
                                newPass: newPasswordController.text);
                          }
                        },
                        text: 'Change Password')

                  ],
                ),
              ),
            )
        );
      },
    );
  }


}
