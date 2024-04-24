import 'package:flutter/material.dart';
//import 'package:just_audio/just_audio.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
//import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
//import 'package:record/record.dart';
// class AudioPageView extends StatefulWidget {
//   const AudioPageView({super.key});
//
//   @override
//   AudioPageViewState createState() => AudioPageViewState();
// }
//
// class AudioPageViewState extends State<AudioPageView> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   final AudioRecorder _recorder = AudioRecorder();
//   bool _isRecording = false;
//   String? _filePath;
//   double _currentPosition = 0;
//   double _totalDuration = 0;
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     _recorder.dispose();
//     super.dispose();
//   }
//
//   Future<void> _startRecording() async {
//     final bool isPermissionGranted = await _recorder.hasPermission();
//     if (!isPermissionGranted) {
//       return;
//     }
//
//     final directory = await getApplicationDocumentsDirectory();
//     // Generate a unique file name using the current timestamp
//     String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
//     _filePath = '${directory.path}/$fileName';
//
//     // Define the configuration for the recording
//     const config = RecordConfig(
//       // Specify the format, encoder, sample rate, etc., as needed
//       encoder: AudioEncoder.aacLc, // For example, using AAC codec
//       sampleRate: 44100, // Sample rate
//       bitRate: 128000, // Bit rate
//     );
//
//     // Start recording to file with the specified configuration
//     await _recorder.start(config, path: _filePath!);
//     setState(() {
//       _isRecording = true;
//     });
//   }
//
//   Future<void> _stopRecording() async {
//     final path = await _recorder.stop();
//     setState(() {
//       _isRecording = false;
//     });
//   }
//
//   Future<void> _playRecording() async {
//     if (_filePath != null) {
//       await _audioPlayer.setUrl('https://firebasestorage.googleapis.com/v0/b/graduationproject-f494b.appspot.com/o/audio_2024-02-18_21-55-37.ogg?alt=media&token=44e50ae8-11cb-4cca-826c-fffde296fdca');
//       _totalDuration = _audioPlayer.duration?.inSeconds.toDouble() ?? 0;
//       _audioPlayer.play();
//
//       _audioPlayer.positionStream.listen((position) {
//         setState(() {
//           _currentPosition = position.inSeconds.toDouble();
//         });
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Modern Audio Recorder'),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               _isRecording ? Icons.mic : Icons.mic_none,
//               size: 100,
//               color: _isRecording ? Colors.red : Colors.blue,
//             ),
//             const SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _isRecording ? null : _startRecording,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 15),
//                   ),
//                   child: const Text('Record'),
//                 ),
//                 const SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _isRecording ? _stopRecording : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 15),
//                   ),
//                   child: const Text('Stop'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: !_isRecording ? _playRecording : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//               ),
//               child: const Text('Play'),
//             ),
//             const SizedBox(height: 15,),
//             Container(
//               decoration: BoxDecoration(
//                 color: basicColor,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               padding:const EdgeInsets.all(5),
//               child: Slider(
//                 activeColor: whiteColor,
//                 inactiveColor: entertainmentColor,
//                 thumbColor: whiteColor,
//                 value: _currentPosition,
//                 max: _totalDuration,
//                 onChanged: (value) {
//                   setState(() {
//                     _currentPosition = value;
//                   });
//                   _audioPlayer.seek(Duration(seconds: value.toInt()));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AudioPageView extends StatelessWidget {
  const AudioPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: SafeArea(child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Modern Audio Recorder',appBarStyle: CustomTextStyle.commonSignThinDark,),
            SizedBox(
              height: height*0.7,
              child: ListView.builder(
                  itemCount: 10,
                  physics:const BouncingScrollPhysics(),
                  itemBuilder:(context,index){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        width: width*0.6,
                          decoration: BoxDecoration(
                            color: forthColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding:const EdgeInsets.all(5),
                          child: SizedBox(
                            child: Slider(
                              activeColor: whiteColor,
                              inactiveColor: thirdColor,
                              thumbColor: whiteColor,
                              value: 2,
                              max: 20,
                              onChanged: (value) {},
                            ),
                          )),
                    );
                  }),
            ),
            SizedBox(height: height*0.05,),
            const TimerButton(),
          ],
        ),
      )),
    );
  }
}

class SwipeIcon extends StatefulWidget {

  const SwipeIcon({
    Key? key,

  }) : super(key: key);

  @override
  State<SwipeIcon> createState() => _SwipeIconState();
}

class _SwipeIconState extends State<SwipeIcon> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-1.0, 0.0)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background:const Icon(Icons.delete,color: Colors.white,),
      secondaryBackground:const Icon(Icons.stop,color: Colors.white,),
      onDismissed: (direction){
        if(direction==DismissDirection.startToEnd){
          debugPrint('deleted');
        }
        else if(direction==DismissDirection.endToStart){
          debugPrint('stopped');
        }
      },
      child: SlideTransition(
        position: _offsetAnimation!,
        child: const Icon(Icons.mic,color: Colors.black,)
      ),
    );
  }
}
class TimerButton extends StatefulWidget {
  const TimerButton({super.key});

  @override
  TimerButtonState createState() => TimerButtonState();
}

class TimerButtonState extends State<TimerButton> {
  final stopwatch = Stopwatch();
  String timerDisplay = '00:00.00';
  Color color=forthColor;
  void _handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
    _updateTimerDisplay();
  }

  void _updateTimerDisplay() {
    setState(() {
      final elapsedTime = stopwatch.elapsed;
      timerDisplay =
      '${elapsedTime.inMinutes.toString().padLeft(2, '0')}:${elapsedTime.inSeconds.toString().padLeft(2, '0')}.${elapsedTime.inMilliseconds.toString().padLeft(3, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onLongPress: (){
              color=secondaryColor;
              setState(() {
                _handleStartStop();
              });
            },
            onLongPressUp: (){
              color=forthColor;
              setState(() {
                _handleStartStop();
              });

              //debugPrint('recording finished ...');
            },
            child:CircleAvatar(
                radius: 30,
                backgroundColor: color,
                child: const Icon(Icons.mic,color: basicColor,))),
        const SizedBox(width: 10.0),
        Text(timerDisplay),
      ],
    );
  }
}