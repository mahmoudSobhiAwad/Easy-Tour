import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
class RoomAvailabilityView extends StatelessWidget {
  const RoomAvailabilityView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network('https://th.bing.com/th/id/R.c5fed38e7f5bf5aab350c7dca0aa7abb?rik=7WAuI2PjKCnocQ&pid=ImgRaw&r=0',
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
                      Text('Paradise Resort',style: CustomTextStyle.privateTourTitle.copyWith(fontWeight: FontWeight.normal,color: Colors.white),),
                      SizedBox(
                          height: height*0.075,
                          child: SingleChildScrollView(child: Text('Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Pantai Waecicu, Labuan Bajo, Kec. Komodo, Kabupaten Manggarai Barat, Nusa Tenggara Tim. 86554',style: CustomTextStyle.commonProfileDark.copyWith(color: Colors.white),)))
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: height*0.02,
                right: width*0.05,
                child: Column(
                  children: [
                    ...List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network('https://brabbucontract.com/inspirations-and-ideas/wp-content/uploads/2019/09/Hotel-Bedroom-Decor.jpg',height: height*0.06,width: width*0.12,fit: BoxFit.cover,)),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height*0.01,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About Us',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                SizedBox(
                    height: height*0.1,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Text(text,style: CustomTextStyle.commonFontThinLight))),
                SizedBox(height: height*0.01,),
                const Text('Services & Facilities',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                SizedBox(
                  height: height*0.15,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 8,crossAxisSpacing: width*0.2,mainAxisSpacing: height*0.015), itemBuilder: (context,index){
                    return const ServicesFacilitiesItem();
                  }),
                ),
                SizedBox(height: height*0.01,),
                const Text('Available Rooms',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                Table(
                  columnWidths: const {
                    0:FractionColumnWidth(0.15),
                    1:FractionColumnWidth(0.15),
                    2:FractionColumnWidth(0.3),
                    3:FractionColumnWidth(0.25),
                    4:FractionColumnWidth(0.15),
                  },
                  border: TableBorder.all(
                    color: secondaryColor,
                    width: 2,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  children: [
                    buildTableRow(['Room Type','Price','Properties','Cancel Cost','Room Num']),
                    ...List.generate(5, (index) => buildTableWithWidget(
                       [
                         const Text('Standard Sea View Room'),
                         const Text('750 Euro'),
                         const Column(
                          children: [
                            Row(
                              children: [
                                Text('Packaging'),
                                Icon(Icons.close,color: closeColor,),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                Icon(Icons.payment,),
                                Text('AT WEB'),
                              ],
                            ),
                          ],
                        ),
                         Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.monetization_on_rounded,color: closeColor,),
                                Text('750'),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.timer,),
                                SizedBox(
                                    width: width*0.13,
                                    child: const Text('5 May 2024 12:00 PM')),
                              ],
                            ),
                          ],
                        ),
                         const Column(
                           children: [
                             CircleAvatar(
                                 child: Icon(Icons.add,)),
                             Text('0'),
                             CircleAvatar(
                                 child: FaIcon(FontAwesomeIcons.minus)),
                           ],
                         ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: height*0.02,),
                Center(child: CustomLoginButton(label: 'Book',altWidth: width*0.33,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
String text='Welcome to resort paradise we ensure the best service during your stay in bali with an emphasis on customer comfort. Enjoy Balinese specialties, dance and music every Saturday for free at competitive prices. You can enjoy all the facilities at our resort';
class ServicesFacilitiesItem extends StatelessWidget {
  const ServicesFacilitiesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const CircleAvatar(
          radius: 10,
          backgroundColor: whatsAppColor,
          child: Icon(Icons.check,color: Colors.white,size: 15,),
        ),
        const SizedBox(width: 5,),
        Text('Swimming Pool',style: CustomTextStyle.commonFontThinLight.copyWith(fontSize: 12),),
      ],
    );
  }
}

TableRow buildTableRow (List<String>cells){
  return TableRow(children: [
    ...List.generate(cells.length, (index) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(cells[index],style: CustomTextStyle.commonFontThinLight,textAlign: TextAlign.center,),
    )),
  ]);
}
TableRow buildTableWithWidget (List<Widget>cells){
  return TableRow(children: [
    ...List.generate(cells.length, (index) => Padding(
      padding: const EdgeInsets.all(5.0),
      child: cells[index],
    )),
  ]);
}