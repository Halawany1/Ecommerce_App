import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/models/get_favourite_model/GetFavouriteModel.dart';
import 'package:untitled/modules/product_screen.dart';

import '../constants.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          backgroundColor: backgroundColor,
          body: ConditionalBuilder(
            condition:cubit.getFavouriteModel!=null,
            builder: (context) {
              return  ConditionalBuilder(
                condition: cubit.getFavouriteModel!.data!.data!.length!=0,
                builder: (context) {
                  return  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Favourites',
                            style: GoogleFonts.montserrat(fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20,),
                          ListView.separated(
                              itemCount: cubit.getFavouriteModel!.data!.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) =>
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            ProductScreen(
                                                index,cubit.homeModel!.data!.products![index].images!.length
                                            ),));
                                      },
                                      child: buildFavourite(cubit.getFavouriteModel!, index, cubit)))
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) => Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Image.asset('assets/images/favourite.png'),
                      ),
                      SizedBox(height: 20,),
                      Text('NO Favourites',style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color:Colors.black,
                        fontSize: 20
                      ),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\t\t\tYou can add an item to your\n favourites'
                              ' by clicking “Heart Icon”',
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
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator(color: color,)),
          ),
        );
      },
    );
  }

  Material buildFavourite(
      GetFavouriteModel? getFavouriteModel, int index, LayoutCubit cubit) {
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
                  '${getFavouriteModel!.data!.data![index].product!.image}',
                  width: 150,
                ),
                if (getFavouriteModel.data!.data![index].product!.discount != 0)
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
                      '${getFavouriteModel.data!.data![index].product!.name}',
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
                          "\$${getFavouriteModel.data!.data![index].product!.price}",
                          style: TextStyle(fontSize: 15, color: color),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "\$${getFavouriteModel.data!.data![index].product!.oldPrice}",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            cubit.ChangeFavouriteData(getFavouriteModel
                                .data!.data![index].product!.id as int);
                          },
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: cubit.favourites[getFavouriteModel
                                        .data!.data![index].product!.id as int] ==
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
