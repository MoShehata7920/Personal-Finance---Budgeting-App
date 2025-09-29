import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int selectedIndex;

  const BottomNavState(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
