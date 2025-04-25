import 'package:flatypus/services/remote_config/rc_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final rcServiceProvider = Provider<RCService>((ref) {
  final service = RCService();
  // Initialise the service when provider is created and only once
  service.initialise();
  return service;
});
