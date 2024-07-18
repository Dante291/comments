import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigService {
  static FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  static final StreamController<bool> _remoteConfigStreamController =
      StreamController<bool>.broadcast();

  static Future<void> initialize() async {
    await _remoteConfig.setDefaults(<String, dynamic>{
      'showfullemail': false,
    });
    await _remoteConfig.fetchAndActivate();
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      _remoteConfigStreamController.add(_remoteConfig.getBool('showfullemail'));
    });
  }

  static bool get showFullEmail => _remoteConfig.getBool('showfullemail');
}
