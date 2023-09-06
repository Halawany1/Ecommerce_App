import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/constants.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        var cubit=context.read<LayoutCubit>();
        return Scaffold(
          backgroundColor: backgroundColor,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                  statusBarIconBrightness: Brightness.light),
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                "FAQs",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              centerTitle: true,
            ),
          body: ConditionalBuilder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 20,),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context, index) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.blue)
                    ),
                    child: Column(
                      children: [
                        Text('${cubit.questionModel!.data!.data![index].question}',
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                        ),),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left:  8.0),
                          child: Text('${cubit.questionModel!.data!.data![index].answer}',
                          style: GoogleFonts.montserrat(
                              fontSize: 13,
                            color: Colors.black,
                            height: 1.5,
                            fontWeight: FontWeight.w500
                          ),),
                        )
                      ],
                    ),
                  );
                },
                  itemCount: cubit.questionModel!.data!.data!.length,
                ),
              );
            },
            condition: cubit.questionModel!=null,
            fallback: (context) => Center(child: CircularProgressIndicator(color: color,)),
          )
        );
      },
      listener: (context, state) {

      },
    );
  }
}
