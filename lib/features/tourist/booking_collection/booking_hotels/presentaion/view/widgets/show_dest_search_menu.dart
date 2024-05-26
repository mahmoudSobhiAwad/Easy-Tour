
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class ShowResultOfDestSearch extends StatelessWidget {
  const ShowResultOfDestSearch({
    super.key,
    required this.height,
    required this.width,
    required this.onTapMenu,
    this.top,
    this.left,
    required this.searchResults,

  });
  final List<String>searchResults;
  final double height;
  final double width;
  final void Function(String query) onTapMenu;
  final double?top;
  final double?left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:top?? height*0.28,
      left:left?? width*0.05,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height*0.15,
          minHeight: height*0.05,
          maxWidth: width*0.5,
          minWidth: width*0.3,
        ),
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: secondaryColor),
        ),
        child: ListView.builder(
            itemBuilder: (context,index){
              return TextButton(onPressed:(){
                onTapMenu(searchResults[index]);
              } ,child: Text(searchResults[index],textAlign: TextAlign.center,),);
            },
            itemCount:searchResults.length),

      ),
    );
  }
}