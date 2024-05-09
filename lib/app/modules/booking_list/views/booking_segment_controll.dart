import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skycraft/app/constants/theme_data.dart';

class BookingSegmentedControl extends StatefulWidget {
  static const String routeName = 'cupertino/segmented_control';

  const BookingSegmentedControl({super.key});

  @override
  _CupertinoSegmentedControlDemoState createState() =>
      _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState
    extends State<BookingSegmentedControl> {
  final Map<int, Widget> children = <int, Widget>{
    0: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const Text('Requested', style: TextStyle(fontSize: 14)),
    ),
    1: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const Text('On Going', style: TextStyle(fontSize: 14)),
    ),
    2: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const Text('Completed', style: TextStyle(fontSize: 14)),
    ),
  };

  final Map<int, Widget> icons = <int, Widget>{
    0: const Center(
      child: Icon(
        CupertinoIcons.circle_fill,
        size: 200.0,
        color: CupertinoColors.systemRed,
      ),
    ),
    1: const Center(
      child: Icon(
        CupertinoIcons.circle_fill,
        size: 200.0,
        color: CupertinoColors.systemGreen,
      ),
    ),
    2: Container(
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBlue,
      ),
    )
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          // height: 65,
          child: CupertinoNavigationBar(
            padding: const EdgeInsetsDirectional.only(start: 0, end: 0, top: 0),
            // backgroundColor: kPinkColor,
            automaticallyImplyLeading: false,
            border: null,
            middle: SizedBox(
              child: CupertinoSegmentedControl<int>(
                children: children,
                onValueChanged: (int newValue) {
                  setState(() {
                    sharedValue = newValue;
                  });
                },
                groupValue: sharedValue,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: icons[sharedValue],
          ),
        ),
      ],
    );
  }
}
