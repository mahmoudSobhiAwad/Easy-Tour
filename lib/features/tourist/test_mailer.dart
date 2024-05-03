import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class TestSendEmailView extends StatefulWidget {
  const TestSendEmailView({super.key});

  @override
  State<TestSendEmailView> createState() => _TestSendEmailViewState();
}

class _TestSendEmailViewState extends State<TestSendEmailView>with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust animation duration as needed
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2) // Scale animation
        .animate(_animationController!);
  }
  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }


  int _seconds = 0;
  int _minutes = 0;
  bool timerOn=false;
  Timer? _timer;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width*0.75,
                    child:timerOn?
                    Container(
                      decoration: BoxDecoration(
                        color: thirdColor,
                        borderRadius: commonBorderRadius(),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text('counter is: $_minutes:${_seconds.toString().padLeft(2, '0')}'),
                    ) :
                    const CustomTextFormField()),
                ScaleTransition(
                  scale: _scaleAnimation!,
                  child: CircleAvatar(
                      minRadius: 25,
                      maxRadius: 30,
                      backgroundColor: forthColor,
                      child: GestureDetector(
                          onLongPress: ()async{
                            timerOn=true;
                            setState(() {

                            });
                            _animationController?.forward();
                            _seconds = 0;
                            _minutes=0;
                            _timer = Timer.periodic(const Duration(milliseconds: 900), (timer){
                              _incrementTimer();
                            });
                            },
                          onLongPressUp: (){
                            timerOn=false;
                            setState(() {

                            });
                            _animationController?.reverse();
                            _timer?.cancel();
                          },
                          child: const Icon(Icons.mic,size: 25,))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }


  void _incrementTimer() {
    setState(() {
      _seconds++;
      if (_seconds >= 60) {
        _minutes++;
        _seconds = 0;
      }
    });
  }
}

Future<void> tryToSendEmail()async {

}
