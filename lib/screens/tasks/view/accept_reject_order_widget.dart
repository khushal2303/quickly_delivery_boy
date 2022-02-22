import 'package:flutter/material.dart';
import 'package:quickly_delivery/custom_widgets/timer_widget/circular_countdown_timer.dart';
import 'package:quickly_delivery/styles/colors.dart';

class AcceptRejectOrderWidget extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const AcceptRejectOrderWidget());
  }

  const AcceptRejectOrderWidget({Key? key}) : super(key: key);

  @override
  _AcceptRejectOrderWidgetState createState() =>
      _AcceptRejectOrderWidgetState();
}

class _AcceptRejectOrderWidgetState extends State<AcceptRejectOrderWidget> {
  final CountDownController _controller = CountDownController();
  final int _duration = 30;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      _controller.start();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: _duration,

      // Countdown initial elapsed Duration in Seconds.
      initialDuration: 0,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: _controller,

      // Width of the Countdown Widget.
      width: 90,

      // Height of the Countdown Widget.
      height: 90,

      // Ring Color for Countdown Widget.
      ringColor: AppColors.timerRingColor,

      // Ring Gradient for Countdown Widget.
      ringGradient: null,

      // Filling Color for Countdown Widget.
      fillColor: AppColors.primaryColor,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      backgroundColor: AppColors.primaryColor,

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 4.0,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Text Style for Countdown Text.
      textStyle: const TextStyle(
          fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: false,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: false,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: false,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        print('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        // Here, do whatever you want
        print('Countdown Ended');
      },
    ));
  }
}
