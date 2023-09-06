part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}


class ChangeNavBarState extends LayoutState {}

class ChangeCartScreenState extends LayoutState {}


class LoadingHomeDataState extends LayoutState {}

class SuccessHomeDataState extends LayoutState {}

class ErrorHomeDataState extends LayoutState {
  final String error;
  ErrorHomeDataState(this.error);
}

class LoadingGetFaqDataDataState extends LayoutState {}

class SuccessGetFaqDataDataState extends LayoutState {
  final QuestionModel questionModel;

  SuccessGetFaqDataDataState(this.questionModel);

}

class ErrorGetFaqDataDataState extends LayoutState {
  final String error;
  ErrorGetFaqDataDataState(this.error);
}



class LoadingCategoryDataState extends LayoutState {}

class SuccessCategoryDataState extends LayoutState {}

class ErrorCategoryDataState extends LayoutState {
  final String error;
  ErrorCategoryDataState(this.error);
}
class LoadingFavouriteDataState extends LayoutState {}

class SuccessFavouriteDataState extends LayoutState {}

class ErrorFavouriteDataState extends LayoutState {
  final String error;
  ErrorFavouriteDataState(this.error);
}

class SuccessChangeFavouriteDataState extends LayoutState {
  final FavouriteModel ?favouriteModel;

  SuccessChangeFavouriteDataState(this.favouriteModel);

}

class ErrorWhenChangFavouriteDataState extends LayoutState {
  final String error;
  ErrorWhenChangFavouriteDataState(this.error);
}

class LoadingGetCategoryDetailsDataState extends LayoutState {}

class SuccessGetCategoryDetailsDataState extends LayoutState {}

class ErrorGetCategoryDetailsDataState extends LayoutState {
  final String error;
  ErrorGetCategoryDetailsDataState(this.error);
}

class LoadingCartDataState extends LayoutState {}

class SuccessCartDataState extends LayoutState {}

class ErrorCartDataState extends LayoutState {
  final String error;
  ErrorCartDataState(this.error);
}

class MoveRightState extends LayoutState {}
class MoveLeftState extends LayoutState {}
class ChangeIndexItemState extends LayoutState {}
class LoadingSearchState extends LayoutState {}

class SuccessSearchState extends LayoutState {}

class ErrorSearchState extends LayoutState {
  final String error;
  ErrorSearchState(this.error);
}
class GetIdState extends LayoutState {}
class LoadingChangeCartState extends LayoutState {}

class SuccessChangeCartDataState extends LayoutState {
  final CartModel ?cartModel;

  SuccessChangeCartDataState(this.cartModel);

}

class ErrorWhenChangCartDataState extends LayoutState {
  final String error;
  ErrorWhenChangCartDataState(this.error);
}