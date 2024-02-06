import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
    required this.expiryDate,
  });

  final DateTime? expiryDate;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalDurationSeconds = 0;
  double _percent = 1;

  void _startTimer() {
    final expiryDate = widget.expiryDate;
    if (expiryDate == null) return;

    _totalDurationSeconds = expiryDate.difference(DateTime.now()).inSeconds;
    _remainingSeconds = _totalDurationSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _percent = _totalDurationSeconds > 0
              ? _remainingSeconds / _totalDurationSeconds
              : 1;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.expiryDate != oldWidget.expiryDate) {
      _timer?.cancel();

      _percent = 1;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 55,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 55,
              height: 55,
              child: CircularProgressIndicator(
                value: _percent,
                backgroundColor: Colors.black,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 8,
              ),
            ),
            Center(
              child: Text(
                '$_remainingSeconds',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF2D2B2C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
}
