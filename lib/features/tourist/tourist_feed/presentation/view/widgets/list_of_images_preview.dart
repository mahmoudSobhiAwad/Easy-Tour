import 'package:flutter/material.dart';
class ListOfImagesPreview extends StatelessWidget {
  const ListOfImagesPreview({super.key,required this.imagesLinks,required this.height,required this.width});
  final List<String>imagesLinks;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.close,color: Colors.white,)),
          SizedBox(
            height: height*0.8,
            child: PageView.builder(
                itemCount: imagesLinks.length,
                itemBuilder: (context,index){
                  return InteractiveViewer(
                    child: Center(
                      child: Image.network(imagesLinks[index],
                        height: height*0.7,fit: BoxFit.fitWidth,width: width,
                        filterQuality: FilterQuality.high,),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}