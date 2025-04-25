import 'dart:convert';

import 'package:color_log/color_log.dart';
import 'package:flatypus/state/providers/remote_config_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class FirebaseFunctionService {
  Future<void> callNewUserAddedNotification({
    required WidgetRef ref,
    required String? houseId,
    required String? userId,
  }) async {
    clog.info('Executed callNewUserAddedNotification');
    try {
      if(houseId == null || userId == null) return;
      // Get firebase function url from the remote config
      final String functionUrl =
          await ref.watch(rcServiceProvider).getNewUserAddedMessageFunction();
      if (functionUrl.isEmpty) return;

      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(functionUrl),
        headers: <String, String>{'Content-Type': 'application/json'},
        // You can send data if the function expects it (optional)
        body: jsonEncode(<String, dynamic>{'houseId': houseId, 'userId': userId}),
      );
      clog.checkSuccess(response.statusCode == 200, 'Notification sent successfully.');
    } catch (e) {
      clog.error('Error calling function: $e');
    }
  }
}
