import 'package:flutter_bloc/flutter_bloc.dart';

class TabBoxClientCubit extends Cubit<int> {
  TabBoxClientCubit() : super(0);

  int index = 0;

  void changeTab(int index) {
    this.index=index;
    emit(index);
  }
}
