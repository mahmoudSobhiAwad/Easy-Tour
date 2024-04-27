import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/notification_setup/notification_setup.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'package:prepare_project/features/tour_guide/settings/presentation/manager/tour_guide_setting_cubti.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo_imp.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/manager/tourist_setting_cubit.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/manager/tourist_setting_state.dart';
import 'bloc_observer.dart';
import 'core/utilities/function/set_app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fire_base_options.dart';
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await prepareFutureMainFun();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider( create: (context)=>TouristSettingCubit(settingRepoImp: getIt.get<SettingRepoImp>())..checkAllowingNotify(),),
      BlocProvider( create: (context)=>TourGuideSettingCubit(settingRepoImp: getIt.get<SettingRepoImp>())..checkAllowingNotify(),),
    ],
      child: const MyApp()));
}

Future<void> prepareFutureMainFun() async {
  setUp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  await NotificationSetup().initAwesomeNotification();
  cameras=await availableCameras();
  Bloc.observer=SimpleBlocObserver();
  await SetAppState.setShared();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>OnBoardingCubit()..initOnBoarding(),),
      ],
      child: BlocBuilder<TouristSettingCubit,TouristSettingState>(
        builder: (context,state){
          return MaterialApp.router(
            themeMode:BlocProvider.of<TouristSettingCubit>(context).appMode,
            debugShowCheckedModeBanner: false,
            theme: BlocProvider.of<TouristSettingCubit>(context).appTheme,
            routerConfig: RouterApp.router,
          );
        },
      ),
    );
  }
}
