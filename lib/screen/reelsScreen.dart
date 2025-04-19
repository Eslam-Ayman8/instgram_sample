import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:instgram_sample/screen/add_screen.dart';


class ReelScreenState extends StatefulWidget {
  const ReelScreenState({super.key});

  @override
  State<ReelScreenState> createState() => _ReelScreenStateState();
}

class _ReelScreenStateState extends State<ReelScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('Reels Page'),
        )

    );
  }
}
