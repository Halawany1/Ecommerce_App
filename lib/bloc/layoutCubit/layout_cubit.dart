

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:untitled/Network/end_points.dart';
import 'package:untitled/Network/remote/dio_helper.dart';
import 'package:untitled/models/cart_model/CartModel.dart';
import 'package:untitled/models/category_details_model/category_details_model.dart';
import 'package:untitled/models/category_model/Categories.dart';
import 'package:untitled/models/get_cart_model/CartModel.dart';
import 'package:untitled/models/home_model/HomeModel.dart';
import 'package:untitled/models/question_model/question_model.dart';
import 'package:untitled/modules/category_screen.dart';
import 'package:untitled/modules/home_screen.dart';
import 'package:untitled/modules/settings_screen.dart';

import '../../constants.dart';
import '../../models/cart_model/CartModel.dart';
import '../../models/favourite_model/FavouriteModel.dart';
import '../../models/get_favourite_model/GetFavouriteModel.dart';
import '../../models/search_model/search_model.dart';
import '../../models/user_model/User_Model.dart';
import '../../modules/favourite_screen.dart';
import '../../modules/search_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  bool cartscreen=false;
  void ChangeCartScreen(){
    cartscreen=true;
    emit(ChangeCartScreenState());
  }

  int bottomNavIndex =0;
  void ChangeNavBar(int index){
    bottomNavIndex=index;
    cartscreen=false;
    emit(ChangeNavBarState());
  }
  List<Widget>screens=[
    HomeScreen(),
    FavouriteScreen(),
    SearchScreen(),
    SettingsScreen()
  ];


  HomeModel ?homeModel;
  Categories ?categoryModel;
  Map<int,bool>favourites={};
  void GetHomeData(){
    emit(LoadingHomeDataState());
   DioHelper.GetData(url: home,
       token: token).
   then((value) {
     homeModel=HomeModel.fromJson(value.data);
     homeModel!.data!.products!.forEach((element) {
       favourites.addAll({
        element.id! as int:element.inFavorites! as bool
      });
     });
     homeModel!.data!.products!.forEach((element) {
       carts.addAll({
         element.id! as int:element.inCart! as bool
       });
     });
     emit(SuccessHomeDataState());
   }).catchError((error){
     print(error.toString());
     emit(ErrorHomeDataState(error.toString()));
   });
  }





  void GetCategoryData(){
    emit(LoadingCategoryDataState());
    DioHelper.GetData(url: categories).
    then((value) {
      categoryModel=Categories.fromJson(value.data);
      emit(SuccessCategoryDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCategoryDataState(error.toString()));
    });
  }
  CategoryDetailsModel ?categoryDetailsModel;
  void GetCategoryDetailsData(int ?id){
    idkey=id;
    emit(LoadingGetCategoryDetailsDataState());
    if(id!=null) {
      DioHelper.GetData(
          url: categories + "/$idkey",
          token: token).
      then((value) {
        categoryDetailsModel = CategoryDetailsModel.fromJson(value.data);
        emit(SuccessGetCategoryDetailsDataState());
      }).catchError((error) {
        print(error.toString());
        emit(ErrorGetCategoryDetailsDataState(error.toString()));
      });
    }
  }

  GetFavouriteModel ?getFavouriteModel;
  void GetFavouriteData(){
    emit(LoadingFavouriteDataState());
    DioHelper.GetData(
        url: favorite,
        token: token).
    then((value) {
      getFavouriteModel=GetFavouriteModel.fromJson(value.data);
      emit(SuccessFavouriteDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorFavouriteDataState(error.toString()));
    });
  }
  FavouriteModel ?favouriteModel;
  void ChangeFavouriteData(int id){
    favourites[id]=!favourites[id]!;
    if(favouriteModel!=null) {
      emit(SuccessChangeFavouriteDataState(favouriteModel));
    }
    DioHelper.PostData(url: favorite,
    data: {
      'product_id':id
    },
      token: token
    ).
    then((value) {
      favouriteModel=FavouriteModel.fromJson(value.data);
      if(favouriteModel!.status==true){
        GetFavouriteData();
      }else{
        favourites[id]=!favourites[id]!;
      }
      print(value.toString());
      emit(SuccessChangeFavouriteDataState(favouriteModel!));
    }).catchError((error){
      favourites[id]=!favourites[id]!;
      print(error);
      emit(ErrorWhenChangFavouriteDataState(error.toString()));
    });
  }

  CartModel ?cartModel;
  void GetCartData(){
    emit(LoadingCartDataState());
    DioHelper.GetData(
        url: cart,
        token: token).
    then((value) {
      cartModel=CartModel.fromJson(value.data);
      emit(SuccessCartDataState());
    }).catchError((error){
      print(error.toString());
      emit(ErrorCartDataState(error.toString()));
    });
  }

  SearchModel ?searchModel;

  void SearchProduct(String text){
    emit(LoadingSearchState());
    DioHelper.PostData(
        data: {
          "text": text
        },
        token: token,
        url: search
    ).
    then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState(error.toString()));
    });

  }

  int index=0;
  void ChangeIndexItem(int i){
    index=i;
    emit(ChangeIndexItemState());
  }
  void MoveLeft(){
    if(index>0){
      index--;
    }
    emit(MoveLeftState());
  }

  void MoveRight(int i){
    if(index<i-1){
      index++;
    }
    emit(MoveRightState());
  }
  Map<int,bool>carts={};
  void ChangeCartData(int id){
    carts[id]=!carts[id]!;
      emit(SuccessChangeCartDataState(cartModel!));
      DioHelper.PostData(
          url: cart,
          data: {
            'product_id': id
          },
          token: token
      ).
      then((value) {
          GetCartData();
        print(value.toString());
        emit(SuccessChangeCartDataState(cartModel!));
      }).catchError((error) {
        carts[id]=!carts[id]!;
        print(error);
        emit(ErrorWhenChangCartDataState(error.toString()));
      });

  }
  QuestionModel ?questionModel;
  void GetQuestionData(){
    emit(LoadingGetFaqDataDataState());
    DioHelper.GetData(url: faqs).then((value) {
      questionModel=QuestionModel.fromJson(value.data);
      emit(SuccessGetFaqDataDataState(questionModel!));
    }).catchError((error){
      emit(ErrorGetFaqDataDataState(error));
    });
  }

}
