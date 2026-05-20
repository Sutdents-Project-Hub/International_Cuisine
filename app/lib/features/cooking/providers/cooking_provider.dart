import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CookingProvider extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  Timer? _timer;
  int _secondsRemaining = 0;
  bool _isTimerRunning = false;
  bool _ttsEnabled = true;
  double _speechRate = 0.5;

  int get secondsRemaining => _secondsRemaining;
  bool get isTimerRunning => _isTimerRunning;
  bool get ttsEnabled => _ttsEnabled;
  double get speechRate => _speechRate;

  CookingProvider() {
    _tts.setSpeechRate(_speechRate);
  }

  Future<void> setSpeechRate(double value) async {
    _speechRate = value;
    await _tts.setSpeechRate(value);
    notifyListeners();
  }

  void toggleTts(bool enabled) {
    _ttsEnabled = enabled;
    notifyListeners();
  }

  Future<void> speakStep(String text) async {
    if (!_ttsEnabled || text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.speak(text);
  }

  void startTimer(int seconds) {
    stopTimer();
    _secondsRemaining = seconds;
    _isTimerRunning = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        stopTimer();
      } else {
        _secondsRemaining--;
        notifyListeners();
      }
    });
  }

  void stopTimer({bool notify = true}) {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
    if (notify) notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tts.stop();
    super.dispose();
  }
}
