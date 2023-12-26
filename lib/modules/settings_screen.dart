import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/Network/end_points.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/bloc/loginAuthenticationCubit/user_cubit.dart';
import 'package:untitled/models/data_settings_model/data_settings_model.dart';
import 'package:untitled/modules/profile_screen.dart';
import 'package:untitled/modules/question_screen.dart';
import 'package:untitled/shared/component.dart';

import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SettingsModel>accountData = [
      SettingsModel(icon: CupertinoIcons.question_circle_fill, text: "FAQs"),
      SettingsModel(icon: Icons.light_mode, text: "Dark Mode"),
      SettingsModel(
          icon: Icons.delivery_dining_outlined, text: "Delivery Information"),
      SettingsModel(icon: Icons.payment, text: "Payment Information"),
      SettingsModel(icon: Icons.notification_important_rounded,
          text: "Notification Settings"),
      SettingsModel(icon: Icons.language, text: "Languages"),
    ];
    return BlocConsumer<UserCubit, UserState>(
      builder: (context, state) {
        var cubit = context.read<UserCubit>();
        return Scaffold(
          backgroundColor: backgroundColor,
          body: ConditionalBuilder(
            condition: cubit.userModel!=null,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      buildMaterialpersonal(cubit,context),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Account',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if(index==0){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScreen(),));
                                }
                              },
                              child: BuildSettingsContainer(
                                  icon: accountData[index].icon,
                                  text: accountData[index].text),
                            );
                          },
                          separatorBuilder: (context, index) =>
                          const  SizedBox(height: 20,),
                          itemCount: accountData.length)
                    ],
                  ),
                ),
              );
            },
            fallback: (context) =>const Center(child: CircularProgressIndicator(color: color,)),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildMaterialpersonal(UserCubit cubit,context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfileScreen(),));
      },
      child: Material(
        elevation: 5,
        child: Container(
          color: Colors.blue.withOpacity(0.6),
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cubit.userModel!.data!.name}',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Personal Information',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                const  Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25,
                  color: Colors.black45,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
