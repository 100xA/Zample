import 'package:bloc/bloc.dart';
import 'package:zample/components/home/bloc/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  void switchToTab(
    int index,
  ) {
    emit(
      HomeState(
        index: index,
      ),
    );
  }
}
