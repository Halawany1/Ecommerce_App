import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/constants.dart';

import '../shared/component.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
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
                  Text("Forgot\npassword?",
                      style: GoogleFonts.alice(
                          fontSize: 45, fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 50,
                  ),
                  BuildFormField(
                      hinttext: "Enter your email address",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "*",
                            style: TextStyle(
                                fontSize: 14, color: color),
                          ),
                        ),
                        Text(
                          "We will send you a message to set or reset\nyour new password",
                          style: TextStyle(
                            height: 1.3,
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  BuildElevatedButton(
                      text: "Submit",
                      onpress: () {
                        formKey.currentState!.validate();
                      }),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
