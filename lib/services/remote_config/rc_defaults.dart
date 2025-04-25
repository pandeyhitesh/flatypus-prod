import 'dart:convert';

import 'package:flatypus/services/remote_config/rc_keys.dart';

class RCDefaults {
  static Map<String, dynamic> defaults = {
    RCKeys.msgConfigs: jsonEncode({
      "base_url": "",
      "new_user_added_fn": "",
      "temp": "temp"
    }),
  };
}
