import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class Relogio extends StatefulWidget {
  @override
  _RelogioState createState() => _RelogioState();
}

class _RelogioState extends State<Relogio> {
  @override
  Widget build(BuildContext context) {
    return DigitalClock(
      hourMinuteDigitTextStyle: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Colors.black),
      secondDigitTextStyle:
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
      colon: Text(
        ":",
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
