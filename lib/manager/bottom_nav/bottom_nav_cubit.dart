import 'package:bloc/bloc.dart';
import 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(0));

  void changeTab(int index) {
    emit(BottomNavState(index));
  }
}
