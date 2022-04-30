import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/join_metting_screen.dart';
import 'package:zoom_clone/services/jitsi_meet_methods.dart';
import 'package:zoom_clone/widgets/customhomebutton.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({
    Key? key,
  }) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMetting() async {
    var random = Random();
    String roomName = (random.nextInt(1000000) + 1000000).toString();
    _jitsiMeetMethods.createMetting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMetting(context) {
    Navigator.of(context).pushNamed(JoinMeetingScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomHomeButton(
            onPressed: createNewMetting,
            icon: Icons.videocam,
            text: 'New Meeting',
          ),
          CustomHomeButton(
            onPressed: () => joinMetting(context),
            icon: Icons.add_box_rounded,
            text: 'Join Meeting',
          ),
          CustomHomeButton(
            onPressed: () {},
            icon: Icons.calendar_today,
            text: 'Schedule ',
          ),
          CustomHomeButton(
            onPressed: () {},
            icon: Icons.arrow_upward_rounded,
            text: ' Share Screen',
          ),
        ],
      ),
      const Expanded(
          child: Center(
              child: Text('Create and Join Metting with Just a Simple Click'))),
    ]);
  }
}
