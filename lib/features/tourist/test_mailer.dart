import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_cubit.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:prepare_project/core/utilities/basics.dart';
// class TestSendEmailView extends StatelessWidget {
//   const TestSendEmailView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     String username = 'sender_email@gmail.com';
//     String password = 'qonjhdrkbipkeiwv';
//     final message = Message()
//       ..from = Address(username, 'Mahmoud Awad Mohamed')
//       ..recipients.add('sobhimahmoud003@gmail.com')
//       ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//       ..text = 'This is the plain text.\nThis is line 2 of the text part.';
//
//     final smtpServer = gmail(username, password);
//     return  Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: CircleAvatar(
//                 minRadius: 25,
//                 maxRadius: 50,
//                 backgroundColor: forthColor,
//                 child: IconButton(onPressed: ()async{
//                   await tryToSendEmail(message: message, smtpServer: smtpServer);
//                 }, icon: const Icon(Icons.email,size: 50,))),
//           )
//         ],
//       ),
//     );
//   }
// }
// Future<void> tryToSendEmail({required Message message,required SmtpServer smtpServer})async{
//   try {
//     final sendReport = await send(message, smtpServer);
//     debugPrint('Message sent: $sendReport');
//   } on MailerException catch (e) {
//     print(e);
//     debugPrint('Message not sent.');
//     for (var p in e.problems) {
//       debugPrint('Problem: ${p.code}: ${p.msg}');
//     }
//   }
// }
class TestSendEmailView extends StatelessWidget {
  const TestSendEmailView({super.key,this.testList,this.cubit});
final List<String>?testList;

final CustomTripCubit?cubit;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);

    return Scaffold(
      body: SafeArea(child:Column(
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Test',),
          SizedBox(height: height*0.05,),
          Expanded(
            child: GridView.builder(
                padding:const EdgeInsets.all(10),
                itemCount: governments.length,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 20), itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  if(testList!=null){
                    if(testList!.contains(governments[index])){
                      testList!.remove(governments[index]);
                    }
                    else{
                      testList?.add(governments[index]);
                      cubit?.refreshPage();
                    }
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: forthColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:const EdgeInsets.all(10),
                  child: Center(child: Text(governments[index],style: const TextStyle(color: Colors.white),)),
                ),
              );
            }),
          ),
          SizedBox(height: height*0.05,),
        ],
      )),
    );
  }
}
