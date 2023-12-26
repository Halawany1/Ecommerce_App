import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/bloc/layoutCubit/layout_cubit.dart';
import 'package:untitled/models/cart_model/CartModel.dart';
import 'package:untitled/models/get_cart_model/CartModel.dart';
import 'package:untitled/models/get_favourite_model/GetFavouriteModel.dart';
import 'package:untitled/modules/product_screen.dart';
import 'package:untitled/shared/component.dart';

import '../constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return Scaffold(
          bottomSheet: Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 15,
            child: Container(
                width: double.infinity,
                height: 95,
                decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text('Total Price',style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                          ),),
                          const SizedBox(height: 10,),
                          Text('\$${cubit.cartModel!.data!.total}',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                      const Spacer(),
                      BuildElevatedButton(
                          width: 250,
                          height: 55,
                          onpress: () {
                          },
                          text: 'Checkout')
                    ],
                  ),
                )
            ),
          ),
          backgroundColor: backgroundColor,
          body: ConditionalBuilder(
            condition:cubit.cartModel!=null,
            builder: (context) {
              return  ConditionalBuilder(
                condition: cubit.cartModel!.data!.cartItems!.isNotEmpty,
                builder: (context) {
                  return  SingleChildScrollView(
                    physics:const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Cart',
                            style: GoogleFonts.montserrat(fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20,),
                          ListView.separated(
                              itemCount: cubit.cartModel!.data!.cartItems!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) =>
                                  Dismissible(
                                    key: UniqueKey(),
                                      background: Container(
                                        color: Colors.red,
                                        height: 150,
                                        child:const Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 28.0),
                                              child: Icon(Icons.delete,color: Colors.white
                                                ,size: 50,),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        cubit.ChangeCartData(cubit.cartModel!
                                            .data!.cartItems![index].product!.id as int);
                                      },
                                      child: buildFavourite(cubit.cartModel!, index, cubit))),
                          const SizedBox(height: 80,),
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
                        child: Image.asset('assets/images/cart.png'),
                      ),
                      const SizedBox(height: 20,),
                      Text('Your cart is empty',style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color:Colors.black,
                          fontSize: 20
                      ),),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Check out what's trending",
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
            fallback: (context) =>const Center(child: CircularProgressIndicator(color: color,)),
          ),
        );
      },
    );
  }

  Material buildFavourite(
      CartModel? cartModel, int index, LayoutCubit cubit) {
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
                  '${cartModel!.data!.cartItems![index].product!.image}',
                  width: 150,
                ),
                if (cartModel.data!.cartItems![index].product!.discount != 0)
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
              width: 10,
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
                      '${cartModel.data!.cartItems![index].product!.name}',
                      style:const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(

                    children: [
                      Text(
                        "\$${cartModel.data!.cartItems![index].product!.price}",
                        style: TextStyle(fontSize: 15, color: color),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "\$${cartModel.data!.cartItems![index].product!.oldPrice}",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                      const Spacer(),

                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Quantity : ${cubit.cartModel!.data!.cartItems![index].quantity}',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
