import 'dart:convert';

import 'package:color_log/color_log.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flatypus/services/remote_config/rc_defaults.dart';
import 'package:flatypus/services/remote_config/rc_keys.dart';
import 'package:flutter/cupertino.dart';

class RCService {
  final FirebaseRemoteConfig _remoteConfig;

  RCService({FirebaseRemoteConfig? remoteConfig})
    : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> initialise() async {
    try {
      // Set default values
      await _remoteConfig.setDefaults(RCDefaults.defaults);

      // Configure fetch settings
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(milliseconds: 0),
        ),
      );

      // Fetch and activate remote config
      final updated = await _remoteConfig.fetchAndActivate();
      debugPrint('Remote Config fetched and activated: $updated');

      // Log the current value of msgConfigs for debugging
      final msgConfigs = _remoteConfig.getString(RCKeys.msgConfigs);
      debugPrint('Current msgConfigs: $msgConfigs');
    } catch (e) {
      clog.error('Error initializing RC: $e');
    }
  }

  // Getters for Remote Config values
  String getWelcomeMessage() => _remoteConfig.getString(RCKeys.hello);
  String getMessaginConfigs() => _remoteConfig.getString(RCKeys.msgConfigs);
  // String getMessaginBaseUrl() => _remoteConfig.getString(RCKeys.msgBaseUrl);
  Future<String> getNewUserAddedMessageFunction() async{
    await _remoteConfig.fetchAndActivate();
    final msgConfigs = getMessaginConfigs();
    final baseUrl = jsonDecode(msgConfigs)['base_url'];
    final fnName = jsonDecode(msgConfigs)['new_user_added_fn'];
    if (baseUrl.isEmpty || fnName.isEmpty) return '';
    print('functionUrl: $baseUrl$fnName}');
    return '$baseUrl$fnName';
  }
}
