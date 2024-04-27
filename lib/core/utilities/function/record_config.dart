import 'package:record/record.dart';

const config = RecordConfig(
  encoder: AudioEncoder.aacLc, // For example, using AAC codec
  sampleRate: 44100, // Sample rate
  bitRate: 128000, // Bit rate
);