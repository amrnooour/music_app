import 'package:permission_handler/permission_handler.dart';

void requestPermission() {
  Permission.storage.request();
}
