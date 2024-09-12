import 'package:flutter_uxcam/flutter_uxcam.dart';

void initUXCam() {
  FlutterUxcam
      .optIntoSchematicRecordings(); // Confirm that you have user permission for screen recording
  FlutterUxConfig config = FlutterUxConfig(
      userAppKey: "me2y035e6t3xsvy", enableAutomaticScreenNameTagging: false);
  FlutterUxcam.startWithConfiguration(config);
}
