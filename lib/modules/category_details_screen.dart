import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/models/category_details_model/category_details_model.dart';
import 'package:untitled/models/category_model/Categories.dart';
import 'package:untitled/models/get_favourite_model/GetFavouriteModel.dart';

import '../constants.dart';

class CategoryDetailsScreen extends StatelessWidget {
  String name;
  CategoryDetailsScreen(this.name);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.blue,
                statusBarIconBrightness: Brightness.light
            ),
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(
                color: Colors.white
            ),
            title: Text(name, style: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),),
            centerTitle: true,
          ),
          backgroundColor: backgroundColor,
          body: ConditionalBuilder(
            condition: state is! LoadingGetCategoryDetailsDataState,
            builder: (context) {
              return  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                          itemCount: cubit.categoryDetailsModel!.data!.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (context, index) =>
                              buildFavourite(cubit.categoryDetailsModel!, index, cubit))
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator(color: color,)),
          ),
        );
      },
    );
  }

  Material buildFavourite(
      CategoryDetailsModel ?categoryDetailsModel, int index, LayoutCubit cubit) {
    return Material(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        height: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  height: 150,
                  '${categoryDetailsModel!.data!.data![index].image}',
                  width: 150,
                ),
                if (categoryDetailsModel.data!.data![index].discount != 0)
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 20,
                      color: color,
                      child: Text(
                        'Discount'.toUpperCase(),
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),

              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '${categoryDetailsModel.data!.data![index].name}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,right: 9),
                    child: Row(
                      children: [
                        Text(
                          "\$${categoryDetailsModel.data!.data![index].price}",
                          style: TextStyle(fontSize: 15, color: color),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "\$${categoryDetailsModel.data!.data![index].oldPrice}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              decoration:TextDecoration.lineThrough),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            cubit.ChangeFavouriteData(categoryDetailsModel
                                .data!.data![index].id as int);
                          },
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: cubit.favourites[categoryDetailsModel
                                .data!.data![index].id as int] ==
                                true
                                ? color
                                : Colors.grey.withOpacity(0.9),
                            child: Icon(
                              size: 17,
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
