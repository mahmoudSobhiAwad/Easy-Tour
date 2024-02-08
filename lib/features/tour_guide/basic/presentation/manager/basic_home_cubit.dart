import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tour_guide/basic/presentation/manager/basic_home_state.dart';

class BasicHomeCubit extends Cubit<BasicHomeState>{
  BasicHomeCubit():super(InitialBasicHomeState());
  int currIndex=0;
  bool noDrawer=true;
  void changeMenuState(){
    noDrawer=!noDrawer;
    emit(ChangeTourGuideHomeBasicState());
  }
  void changeBottomNavIndex(int index) {
    if(index!=currIndex)
    {
      currIndex=index;
    }
    emit(ChangeHomeNavBottomState());
    String? name=SetAppState.prefs?.getString('name');
    print(name);
  }
}