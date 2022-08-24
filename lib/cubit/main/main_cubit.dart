import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentNavBarItem = 2;
  void changeCurrentNavBarItem(int index) {
    currentNavBarItem = index;
    emit(ChangeBottomNavBar());
  }
}