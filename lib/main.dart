import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/splash/presentation/manager/on_boarding_cubit.dart';
import 'bloc_observer.dart';
import 'core/utilities/function/set_app_state.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  cameras=await availableCameras();
  Bloc.observer=SimpleBlocObserver();
  await SetAppState.setShared();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context)=>OnBoardingCubit()..initOnBoarding(),),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           scaffoldBackgroundColor:const Color(0xffffffff) ,
          iconTheme: const IconThemeData(color:basicColor),
            useMaterial3: true,
            primaryColor:basicColor,
            fontFamily: 'inter',
        ),
        routerConfig: RouterApp.router,
      ),
    );
  }
}
