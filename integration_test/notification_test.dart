// import 'package:example/main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:patrol/patrol.dart';
//
// void main() {
//   patrolTest('notification tap test', ($) async {
//     await Firebase.initializeApp();
//     await $.pumpWidgetAndSettle(const MyApp());
//
//     await $('Send notification').tap();
//
//     if (await $.native.isPermissionDialogVisible()) {
//       await $.native.grantPermissionWhenInUse();
//     }
//
//     // wait for notification to show up
//     await Future<void>.delayed(const Duration(seconds: 5));
//
//     await $.native.openNotifications();
//
//     await $.native.tapOnNotificationByIndex(0);
//
//     await $.pumpAndSettle();
//   });
// }
