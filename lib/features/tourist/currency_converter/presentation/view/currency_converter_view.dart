import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/currency_converter/data/repos/currency_repo_imp.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_cubit.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/manager/currency_converter_state.dart';
import 'package:prepare_project/features/tourist/currency_converter/presentation/view/widgets/currency_converter_body.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>CurrencyConverterCubit(currencyRepoImpl: getIt.get<CurrencyRepoImpl>(),nearbyPlacesRepoImpl: getIt.get<NearbyPlacesRepoImpl>())..getCurrencyCodeList(),
      child: BlocConsumer<CurrencyConverterCubit,CurrencyConverterState>(
          builder: (context,state){
            var cubit=BlocProvider.of<CurrencyConverterCubit>(context);
            return Scaffold(
              body: CurrencyConverterBody(height: height, width: width,cubit: cubit,),
            );
            },
          listener: (context,state){}),
    );
  }
}





