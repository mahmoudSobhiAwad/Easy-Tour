import 'dart:async';
import 'package:prepare_project/features/tourist/test_audio/manager/audio_recorder_helper.dart';
import 'package:prepare_project/features/tourist/test_audio/manager/test_audio_cubit.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as path;

class AudioRecorderController{
  final AudioRecorderFileHelper _audioRecorderFileHelper;
  final Function(String message) onError;
  AudioRecorderController(this._audioRecorderFileHelper, this.onError);

  //CONTROLLERS
  final StreamController<int> _recordDurationController = StreamController<int>.broadcast()..add(0);

  //SINK
  Sink<int> get recordDurationInput => _recordDurationController.sink;

  //STREAMS
  Stream<double> get amplitudeStream => _audioRecorder
      .onAmplitudeChanged(const Duration(milliseconds: 160)).map((amp) => amp.current);
  Stream<RecordState> get recordStateStream => _audioRecorder.onStateChanged();

  Stream<int> get recordDurationOutput => _recordDurationController.stream;

  //VARIABLES
  final AudioRecorder _audioRecorder = AudioRecorder();
  Timer? _timer;
  int _recordDuration = 0;

  void _startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDuration++;
      recordDurationInput.add(_recordDuration);
    });
  }

  //METHODS
  Future<void> start() async{
    final isMicPermissionGranted = await getPermissionToRecord();

    if(!isMicPermissionGranted){
      onError("Could not grant mic permission");
      return;
    }

    try{
      final filePath = path.join(
          (await _audioRecorderFileHelper.getRecordsDirectory).path,
          "${DateTime.now().millisecondsSinceEpoch}.m4a"
      );

      await _audioRecorder.start(
          const RecordConfig(),
          path: filePath
      );

      _startTimer();
    }catch(e){
      onError("Could not start the record");
    }
  }

  void resume(){
    _startTimer();
    _audioRecorder.resume();
  }

  Future<void> pause() async{
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  void stop(Function(VoiceNoteModel? voiceNoteModel) onStop) async{
    final recordPath = await _audioRecorder.stop();
    if (recordPath != null){
      onStop(
          VoiceNoteModel(
              name: path.basename(recordPath),
              dateTime: DateTime.now().subtract(Duration(seconds: _recordDuration)),
              path: recordPath
          )
      );
    }else{
      onStop(null);
      onError("Could not stop the record");
    }

  }

  Future<void> delete(String filePath) async{
    await pause();

    try{
      await _audioRecorderFileHelper.deleteRecord(filePath);
    }catch(e){
      onError("Could not delete the record");
    }
  }

  void dispose(){
    _recordDurationController.close();
    _timer?.cancel();
    _timer = null;
    _audioRecorder.dispose();
  }
  Future<bool>getPermissionToRecord()async{
    final AudioRecorder recorder = AudioRecorder();
    final bool isPermissionGranted = await recorder.hasPermission();
    if (!isPermissionGranted) {
      return false;
      //emit(FailureToHavePermissionToRecord(errMessage:'Please Allow device to record audio'));
    }
    else{
      return true;
    }
  }

}