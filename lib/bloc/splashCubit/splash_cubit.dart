import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  bool last=false;
  int index=0;
  void LastSpalshScreen(int val){
    index=val;
    emit(LastSpalshScreenState());
  }
}
