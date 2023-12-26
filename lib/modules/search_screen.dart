import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/models/category_model/Categories.dart';
import 'package:untitled/models/search_model/search_model.dart';
import 'package:untitled/modules/product_screen.dart';
import 'package:untitled/shared/component.dart';

import '../bloc/layoutCubit/layout_cubit.dart';
import '../constants.dart';
import '../models/get_favourite_model/GetFavouriteModel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();

        return Scaffold(
            backgroundColor: backgroundColor,
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    BuildFormField(
                        context: context,
                        prefixIcon: Icons.search,
                        ontap: (value) {
                          cubit.searchModel = null;
                          cubit.SearchProduct(value.toString());
                        },
                        Controller: searchController,
                        validator: null,
                        hinttext: 'Search item.....'),
                    ConditionalBuilder(
                      condition: cubit.searchModel != null,
                      builder: (context) {
                        return cubit.searchModel!.data!.data!.isNotEmpty?
                        ListView.separated(
                            itemCount: cubit.searchModel!.data!.data!.length,
                            physics:const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>const SizedBox(
                                  height: 10,
                                ),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder:
                                    (context) =>
                                    ProductScreen(
                                        index,cubit.searchModel!.data!.data![index]
                                        .images!.length
                                    ),));
                              },
                              child: buildFavourite(
                                  cubit.searchModel!, index, cubit),
                            )):
                        Padding(
                          padding: const EdgeInsets.only(top: 88.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Image.asset('assets/images/search.png'),
                              ),
                              const SizedBox(height: 20,),
                              Text('Result Not Found',style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color:Colors.black,
                                  fontSize: 20
                              ),),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('\t\t\t\t\t\tPlease try again with another\nkeywords or maybe use generic term',
                                    style: GoogleFonts.montserrat(
                                        color:Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        height: 1.5
                                    ),),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      fallback: (context) => ConditionalBuilder(
                        condition: searchController.text.isNotEmpty,
                        builder: (context) =>const Padding(
                          padding:  EdgeInsets.all(28.0),
                          child: LinearProgressIndicator(
                            color: color,
                          ),
                        ),
                        fallback: (context) => Padding(
                          padding: const EdgeInsets.only(top: 88.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Image.asset('assets/images/search.png'),
                              ),
                              const SizedBox(height: 20,),
                              Text('Result Not Found',style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color:Colors.black,
                                  fontSize: 20
                              ),),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('\t\t\t\t\t\tPlease try again with another\nkeywords or maybe use generic term',
                                    style: GoogleFonts.montserrat(
                                        color:Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        height: 1.6
                                    ),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
      listener: (context, state) {},
    );
  }

  Widget buildFavourite(
      SearchModel? searchModel, int index, LayoutCubit cubit) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Material(
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
                    '${searchModel!.data!.data![index].image}',
                    width: 150,
                  ),
                  if (searchModel.data!.data![index].discount != 0)
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
                          style:const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
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
                        '${searchModel.data!.data![index].name}',
                        style:const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 9),
                      child: Row(
                        children: [
                          Text(
                            "\$${searchModel.data!.data![index].price}",
                            style:const TextStyle(fontSize: 15, color: color),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              cubit.ChangeFavouriteData(
                                  searchModel.data!.data![index].id as int);
                            },
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: cubit.favourites[searchModel
                                          .data!.data![index].id as int] ==
                                      true
                                  ? color
                                  : Colors.grey.withOpacity(0.9),
                              child:const Icon(
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
      ),
    );
  }
}
