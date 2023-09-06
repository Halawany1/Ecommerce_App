import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/shared/component.dart';

import '../constants.dart';

class ProductScreen extends StatelessWidget {
  int index;
  int lenght;

  ProductScreen(this.index, this.lenght);

  @override
  Widget build(BuildContext context) {
    var controller = CarouselController();
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          bottomSheet: cubit.homeModel!.data!.products![index].inCart==false?
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildElevatedButton(
                  width: 350,
                    height: 55,
                    onpress: () {
                      cubit.ChangeCartData(cubit.homeModel!.data!.products![index].id as int);
                      Navigator.pop(context);
                    },
                    text: 'Add to Cart')
              ],
            )
          ):Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Found in Cart",style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black45
                  ),)
                ],
              )
          ),
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  cubit.index = 0;
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white),
          ),
          body: ConditionalBuilder(
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 320,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 25,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  cubit.ChangeFavouriteData(cubit
                                      .homeModel!.data!.products![index].id as int);
                                },
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: cubit.favourites[cubit.homeModel!
                                      .data!.products![index].id as int] ==
                                      true
                                      ? color
                                      : Colors.grey.withOpacity(0.9),
                                  child: Icon(
                                    size: 17,
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                width: 280,
                                height: 300,
                                image: NetworkImage(
                                    '${cubit.homeModel!.data!.products![index].images![cubit.index]}'),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 140,
                              child: cubit.index != lenght - 1
                                  ? InkWell(
                                onTap: () {
                                  cubit.MoveRight(lenght);
                                },
                                child: Icon(Icons.arrow_forward_ios_rounded,
                                    color: Colors.black, size: 25),
                              )
                                  : Container(),
                            ),
                            Positioned(
                              left: 10,
                              top: 140,
                              child: cubit.index != 0
                                  ? InkWell(
                                onTap: () {
                                  cubit.MoveLeft();
                                },
                                child: Icon(Icons.arrow_back_ios_new,
                                    color: Colors.black, size: 25),
                              )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cubit.homeModel!.data!.products![index].name}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Price',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 22, fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$${cubit.homeModel!.data!.products![index].price}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Product Details',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${cubit.homeModel!.data!.products![index].description}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Color(0xFF555353)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        color: Colors.grey.withOpacity(0.2),
                      )
                    ],
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator(color: color,)),
            condition:cubit.homeModel!=null ,

          ),
        );
      },
      listener: (context, state) {

      },
    );
  }
}
