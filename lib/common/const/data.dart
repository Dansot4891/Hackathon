import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data.g.dart';

const ACCESS_TOKEN_KEY = "ACCESS_TOKEN";
const REFRESH_TOKEN_KEY = "REFRESH_TOKEN";

// localhost
const emulatorIP = '10.0.2.2:3000';
const simulatorIP = '127.0.0.1:3000';

final ip = Platform.isAndroid ? emulatorIP : simulatorIP;

@Riverpod(keepAlive: true)
FlutterSecureStorage storage(StorageRef ref) {
  return const FlutterSecureStorage();
}
