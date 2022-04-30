import 'package:flutter/material.dart';
import 'package:zoom_clone/services/auth.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:zoom_clone/services/firestore_methods.dart';

class JitsiMeetMethods {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMetting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String userName = '',
  }) async {
    final AuthMethods _authMethods = AuthMethods();
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (userName.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = userName;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..subject = "Meeting with ${_authMethods.user.displayName}"
        ..userDisplayName = name
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
      _firestoreMethods.addToMettingHistory(roomName);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
