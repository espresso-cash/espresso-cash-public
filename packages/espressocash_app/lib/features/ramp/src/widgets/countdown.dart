import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../ui/colors.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.expiryDate,
  });

  final DateTime expiryDate;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  late int _initialDurationSeconds;

  @override
  void initState() {
    super.initState();
    _initialDurationSeconds =
        widget.expiryDate.difference(DateTime.now()).inSeconds;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.expiryDate != oldWidget.expiryDate) {
      _cancelTimer();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.expiryDate.isAfter(DateTime.now())) {
        setState(() {});
      } else {
        _cancelTimer();
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String get _formattedTime {
    final duration = widget.expiryDate.difference(DateTime.now());

    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double get _percent {
    final currentDuration =
        widget.expiryDate.difference(DateTime.now()).inSeconds;

    return currentDuration > 0 ? currentDuration / _initialDurationSeconds : 0;
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: 1 - _percent,
                backgroundColor: CpColors.yellowColor,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
                strokeWidth: 6,
              ),
            ),
            Text(
              _formattedTime,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
}
