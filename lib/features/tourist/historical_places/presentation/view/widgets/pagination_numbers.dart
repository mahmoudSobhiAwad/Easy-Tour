import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class PaginationNumbers extends StatelessWidget {
  const PaginationNumbers({
    super.key,
    required this.width,
    required this.pagIndex,
    required this.changePag,
    required this.pagNumbers,
    required this.controller,
  });

  final double width;
  final int pagIndex;
  final List<int>pagNumbers;
  final void Function(int index) changePag;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: width*0.6,
        child: ListView.separated(
          controller: controller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  changePag(index);
                },
                child: CircleAvatar(
                  backgroundColor: index==pagIndex?basicColor:thirdColor,
                  child:Center(child: Text('${pagNumbers[index]}',style: CustomTextStyle.commonSignThinDark.copyWith(color: index==pagIndex?Colors.white:basicColor),)) ,),
              );
            },
            separatorBuilder: (context,index)
            {
              return const SizedBox(width: 20,);
            }
            , itemCount: pagNumbers.length),
      ),
    );
  }
}
