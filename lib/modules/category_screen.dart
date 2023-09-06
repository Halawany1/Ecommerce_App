import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/models/category_model/Categories.dart';
import 'package:untitled/modules/category_details_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.blue,
                  statusBarIconBrightness: Brightness.light
              ),
              backgroundColor: Colors.blue,
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
              title: Text("Categories", style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),),
              centerTitle: true,
            ),
            backgroundColor: Color(0xFFF9F9F9),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: () {
                          cubit.GetCategoryDetailsData(cubit.categoryModel!.data
                          !.data![index].id!);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  CategoryDetailsScreen(cubit.categoryModel!
                                      .data!.data![index].name!
                                      ),));
                        },
                        child: Row(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 130,
                              width: 130,
                              child: Image.network(
                                '${cubit.categoryModel!.data!.data![index]
                                    .image}',
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text('${cubit.categoryModel!.data!.data![index]
                                .name}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.bold),),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],),
                      ),
                  separatorBuilder: (context, index) => Divider(thickness: 1,),
                  itemCount: cubit.categoryModel!.data!.data!.length),
            )
        );
      },
      listener: (context, state) {

      },
    );
  }
}
