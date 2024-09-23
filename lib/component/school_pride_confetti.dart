import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

class SchoolPrideConfetti extends StatefulWidget {
  @override
  _SchoolPrideConfettiState createState() => _SchoolPrideConfettiState();
}

class _SchoolPrideConfettiState extends State<SchoolPrideConfetti> {
  @override
  void initState() {
    super.initState();
    _launchSchoolPrideConfetti();
  }

  void _launchSchoolPrideConfetti() {
    const colors = [
      Color(0xffe53935),
      Color(0xff2196F3), //give me a hex color for bleu  :  #2196F3
    ];

    int frameTime = 1000 ~/ 24;
    int total = 15 * 1000 ~/ frameTime;
    int progress = 0;

    ConfettiController? controller1;
    ConfettiController? controller2;
    bool isDone = false;

    Timer.periodic(Duration(milliseconds: frameTime), (timer) {
      progress++;

      if (progress >= total) {
        timer.cancel();
        isDone = true;
        return;
      }
      if (controller1 == null) {
        controller1 = Confetti.launch(
          context,
          options: const ConfettiOptions(
              particleCount: 2,
              angle: 60,
              spread: 55,
              x: 0,
              colors: colors),
          onFinished: (overlayEntry) {
            if (isDone) {
              overlayEntry.remove();
            }
          },
        );
      } else {
        controller1!.launch();
      }

      if (controller2 == null) {
        controller2 = Confetti.launch(
          context,
          options: const ConfettiOptions(
              particleCount: 2,
              angle: 120,
              spread: 55,
              x: 1,
              colors: colors),
          onFinished: (overlayEntry) {
            if (isDone) {
              overlayEntry.remove();
            }
          },
        );
      } else {
        controller2!.launch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // This widget does not need to build anything
  }
}