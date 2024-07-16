import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
class ImagesOfRoomWithSmallDetails extends StatelessWidget {
  const ImagesOfRoomWithSmallDetails({
    super.key,
    required this.height,
    required this.width,
    this.imagesPath,
    required this.name,
    this.addressWithCity,
  });

  final double height;
  final double width;
  final List<ImagesPathModel>?imagesPath;
  final String name;
  final String? addressWithCity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          'http://photos.hotelbeds.com/giata/xl/${imagesPath?.first.imagePath}',
          height:height*0.33,
          width: width,
          fit: BoxFit.cover,
          color: basicColor.withOpacity(0.2),
          colorBlendMode: BlendMode.srcOver,
        ),
        Positioned(
          top: height*0.012,
          left: width*0.025,
          child: ClipRRect(
            borderRadius: commonBorderRadius(),
            child: ColoredBox(color: Colors.white.withOpacity(0.4),child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),),
          ),
        ),
        Positioned(
          bottom: height*0.01,
          left: width*0.05,
          child: SizedBox(
            width: width*0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: CustomTextStyle.fontBold21.copyWith(fontWeight: FontWeight.normal,color: Colors.white),),
                SizedBox(
                    height: height*0.075,
                    child: SingleChildScrollView(child: Text(addressWithCity??"",style: CustomTextStyle.fontBold14.copyWith(color: Colors.white),)))
              ],
            ),
          ),
        ),
        imagesPath?.length!=null?Positioned(
          bottom: height*0.02,
          right: width*0.05,
          child: CircleAvatar(
            radius: width*0.1,
            backgroundColor: thirdColor,
            child: TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ListOfImagesInHotel(imagesPathList: imagesPath??[], height: height, width: width);
              }));
            },child: Column(
              children: [
                Text('+${imagesPath?.length??1 -1} images',textAlign: TextAlign.center,style: TextStyle(color: basicColor),),
                Icon(Icons.arrow_forward_ios,color: basicColor),
              ],
            ),),
          )
        ):const SizedBox(),
      ],
    );
  }
}
class ListOfImagesInHotel extends StatelessWidget {
  const ListOfImagesInHotel({super.key,required this.height,required this.width,required this.imagesPathList});
  final double height;
  final double width;
  final List<ImagesPathModel> imagesPathList;
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
                itemCount: imagesPathList.length,
                itemBuilder: (context,index){
                  return InteractiveViewer(
                    child: Center(
                      child: Image.network('http://photos.hotelbeds.com/giata/xl/${imagesPathList[index].imagePath}',
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