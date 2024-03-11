import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/pagination_numbers.dart';

class PaginationInHistoricalPlaces extends StatelessWidget {
  const PaginationInHistoricalPlaces({
    super.key,
    required this.width,
    required this.height,
    required this.decreaseIndex,
    required this.pagIndex,
    required this.increaseIndex,
    required this.changeIndex,
    required this.pageNumbers,
    required this.controller,
  });

  final double width;
  final double height;
  final void Function()increaseIndex;
  final void Function()decreaseIndex;
  final void Function(int index)changeIndex;
  final int pagIndex;
  final List<int>pageNumbers;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width,
        height: height*0.07,
        decoration: BoxDecoration(
          color: thirdColor,
          boxShadow: [
            buildBoxShadow(),
          ],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft:Radius.circular(26),
              bottomRight: Radius.circular(26),
              bottomLeft: Radius.circular(26)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed:decreaseIndex, icon: Icon(Icons.arrow_back_ios_new,color:pagIndex==0?secondaryColor:entertainmentColor,)),
            PaginationNumbers(
              controller: controller,
              width: width,changePag:(int index) {
              changeIndex(index);
            }, pagIndex: pagIndex, pagNumbers: pageNumbers,),
            IconButton(onPressed: increaseIndex, icon:Icon(Icons.arrow_forward_ios,color:pagIndex==pageNumbers.length-1?secondaryColor:entertainmentColor,)),
          ],
        ),
      ),
    );
  }
}