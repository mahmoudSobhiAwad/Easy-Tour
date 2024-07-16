import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/notification_setup/notification_setup.dart';
import 'package:prepare_project/core/utilities/theme_style/theme_mode.dart';
import 'package:prepare_project/features/common_settings/presentation/manager/common_setting_cubit.dart';
import 'package:prepare_project/features/common_settings/presentation/manager/common_setting_states.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo_imp.dart';
import 'bloc_observer.dart';
import 'core/utilities/function/set_app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fire_base_options.dart';
Future<void> main()async {
  WidgetsBinding widgetsBinding=  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await prepareFutureMainFun();
  runApp(
   MultiBlocProvider(
     providers: [
       BlocProvider(create: (context)=>CommonSettingCubit(settingRepoImp: getIt.get<SettingRepoImp>()),),
       BlocProvider(create: (context)=>OnBoardingCubit()..initOnBoarding(),),
     ],
       child: const MyApp()),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 1));
    print("Initialization complete, removing splash screen");
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonSettingCubit,CommonSettingState>(
      builder: (context,state){
        var cubit=BlocProvider.of<CommonSettingCubit>(context);
        return MaterialApp.router(
          darkTheme: darkTheme,
          themeMode:cubit.appMode,
          debugShowCheckedModeBanner: false,
          theme: cubit.appTheme,
          routerConfig: RouterApp.router,
        );
      },
    );
  }
}
Future<void> prepareFutureMainFun() async {
  await setUp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  await NotificationSetup().initAwesomeNotification();
  cameras=await availableCameras();
  Bloc.observer=SimpleBlocObserver();
  await SetAppState.setShared();
}





