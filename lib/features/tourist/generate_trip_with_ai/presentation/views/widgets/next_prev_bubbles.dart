import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/clippers_for_prev_next_widget.dart';

class NextPrevDay extends StatelessWidget {
  const NextPrevDay({
    super.key,
    required this.cubit,
    required this.width,
    required this.height,
  });

  final ViewTripDetailsCubit cubit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            cubit.moveToPrevDay(width*0.16);
          },
          child: ClipPath(
            clipper:CustomClipPathForPervTrip(),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding:const EdgeInsets.only(top: 40,left: 5),
                  height: height*0.2,
                  width: width*0.35,
                  decoration: BoxDecoration(
                    color:cubit.currentDay==0? const Color(0xffF4900C).withOpacity(0.6):const Color(0xffF4900C),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_back_rounded,color: Colors.white,),
                      const SizedBox(width: 10,),
                      Text('Prev\n Day',style: CustomTextStyle.privateTourTitle.copyWith(color: Colors.white,fontSize: 20),)
                    ],),
                )),
          ),
        ),
        GestureDetector(
          onTap: (){
            cubit.moveToNextDay(width*0.16);
          },
          child: ClipPath(
            clipper: CustomClipPathForNextTrip(),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding:const EdgeInsets.only(top: 40,right: 5),
                  height: height*0.2,
                  width: width*0.35,
                  decoration: BoxDecoration(
                    color:cubit.currentDay==9?const Color(0xff5F92D9).withOpacity(0.6):const Color(0xff5F92D9),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Next\n Day',style: CustomTextStyle.privateTourTitle.copyWith(color: Colors.white,fontSize: 20),),
                        const SizedBox(width: 10,),
                        const Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                      ],),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}