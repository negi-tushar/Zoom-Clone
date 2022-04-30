import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/services/auth.dart';
import 'package:zoom_clone/services/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class JoinMeetingScreen extends StatefulWidget {
  const JoinMeetingScreen({Key? key}) : super(key: key);

  static const String id = '/JoinMeetingScreen';
  @override
  State<JoinMeetingScreen> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  late TextEditingController meetingController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    meetingController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMetting(
        roomName: meetingController.value.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        userName: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Join a Metting'),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                controller: meetingController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Room ID',
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: TextField(
                controller: nameController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: _joinMeeting,
                child: const Text('Join'),
                style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: buttonColor),
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MeetingOptions(
              text: 'Audio',
              isMute: isAudioMuted,
              onChanged: onAudioMuted,
            ),
            MeetingOptions(
              text: 'Video',
              isMute: isVideoMuted,
              onChanged: onvideoMuted,
            )
          ],
        ),
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onvideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
