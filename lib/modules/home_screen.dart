import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/models/category_model/Categories.dart';
import 'package:untitled/models/favourite_model/FavouriteModel.dart';
import 'package:untitled/models/home_model/HomeModel.dart';
import 'package:untitled/modules/category_details_screen.dart';
import 'package:untitled/modules/category_screen.dart';
import 'package:untitled/modules/product_screen.dart';
import 'package:untitled/shared/component.dart';

import '../constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is SuccessChangeCartDataState) {
          if (state.cartModel!.status == true) {
            ShowToast(
                message: state.cartModel!.message!,
                state: ToastState.SUCCESS);
          }else{
            ShowToast(
                message: state.cartModel!.message!,
                state: ToastState.ERROR);
          }
        }
        if (state is SuccessChangeFavouriteDataState) {
          if (state.favouriteModel!.status != true) {
            ShowToast(
                message: state.favouriteModel!.message!,
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
            backgroundColor: backgroundColor,
            body: ConditionalBuilder(
              condition: cubit.homeModel != null && cubit.categoryModel != null,
              builder: (context) {
                return buildColumn(cubit.homeModel, cubit.categoryModel, cubit, context);
              },
              fallback: (context) =>const Center(
                  child: CircularProgressIndicator(
                color: color,
              )),
            ));
      },
    );
  }

  Widget buildColumn(HomeModel? homeModel, Categories? categoryModel,LayoutCubit? cubit, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCarouselSlider(homeModel),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.montserrat(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF83758),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesScreen(),
                          ));
                    },
                    child:const Row(
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 120,
              child: ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String category="";
                    for (int i=0;i<cubit!.categoryModel!.data!.data![index].name!.length
                    ;i++){
                      if(cubit.categoryModel!.data!.data![index].name![i]==' ')break;
                      category+=cubit.categoryModel!.data!.data![index].name![i];

                    }
                    return buildCategories(cubit,index,context,category);
                  },
                  separatorBuilder: (context, index) =>const SizedBox(
                        width: 15,
                      ),
                  itemCount: categoryModel!.data!.data!.length),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              'New Featured',
              style: GoogleFonts.montserrat(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 35,
            ),
            GridView.builder(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.59,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 6,
                  crossAxisCount: 2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ProductScreen(
                    index,cubit.homeModel!.data!.products![index].images!.length
                  ),));
                },
                child: Material(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              height: 184,
                              '${homeModel.data!.products?[index].image}',
                              width: double.infinity,
                            ),
                            if (homeModel.data!.products?[index].discount != 0)
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
                                    style:const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            '${homeModel.data!.products?[index].name}',
                            style:const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Text(
                                "\$${homeModel.data!.products?[index].price}",
                                style:const TextStyle(fontSize: 15, color: color),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "\$${homeModel.data!.products?[index].oldPrice}",
                                style:const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  cubit.ChangeFavouriteData(
                                      homeModel.data!.products![index].id as int);
                                },
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: cubit!.favourites[homeModel
                                              .data!
                                              .products![index]
                                              .id as int] ==
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
                ),
              ),
              itemCount: homeModel!.data!.products!.length,
            )
          ],
        ),
      ),
    );
  }

  Column buildCategories(LayoutCubit ?cubit,int index,context,String category) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            cubit.GetCategoryDetailsData(cubit.categoryModel!.data
          !.data![index].id!);

            Navigator.push(context,MaterialPageRoute(builder: (context)
            => CategoryDetailsScreen(cubit.categoryModel!.data!.data![index].name!),) );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    width: 75,
                      height: 75,
                      fit: BoxFit.cover, '${cubit!.categoryModel!.data!.data![index].image}'),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Text(
          maxLines: 3,
          category,
          style: GoogleFonts.montserrat(fontSize: 16,),
        )
      ],
    );
  }

  CarouselSlider buildCarouselSlider(HomeModel? model) {
    return CarouselSlider(
        items: model?.data!.banners!
            .map((e) => Container(
                  width: 360,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color:const Color(0xFFFDFDFD),
                      borderRadius: BorderRadius.circular(15)),
                  child: Image(
                    image: NetworkImage('${e.image}'),
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: 220,
          scrollDirection: Axis.horizontal,
          autoPlay: true,
          autoPlayInterval:const Duration(seconds: 3),
          autoPlayAnimationDuration:const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          initialPage: 0,
          reverse: false,
        ));
  }
}
