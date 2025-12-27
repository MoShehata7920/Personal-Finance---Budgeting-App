import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<int?> {
  CategoryCubit() : super(null);

  void selectIcon(int iconIndex) {
    emit(iconIndex);
  }
}
