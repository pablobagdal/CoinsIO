import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'dart:io' show Platform, isAndroid;

class SimpleSpoiler extends StatefulWidget {
  const SimpleSpoiler({
    super.key,
    required this.balance,
    required this.currency,
  });
  final String balance;
  final String currency;

  @override
  State<SimpleSpoiler> createState() => _SimpleSpoilerState();
}

class _SimpleSpoilerState extends State<SimpleSpoiler> {
  bool _textVisible = true;
  late ShakeDetector? _detector;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb && Platform.isAndroid) {
      _detector?.stopListening();

      _detector = ShakeDetector.autoStart(
        onPhoneShake: (ShakeEvent event) {
          setState(() {
            _textVisible = !_textVisible;
          });
        },
        minimumShakeCount: 2,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 2.7,
      );
    }
  }

  @override
  void dispose() {
    if (!kIsWeb && Platform.isAndroid) {
      _detector?.stopListening();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ElevatedButton(
        onPressed: () => setState(() => _textVisible = !_textVisible),
        child: Text(_textVisible ? 'Скрыть' : 'Показать'),
      ),
      AnimatedOpacity(
        opacity: _textVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Text(
          '${widget.balance} ${widget.currency}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    ],
  );
}
