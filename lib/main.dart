import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skycraft/app/constants/theme_data.dart';
import 'package:skycraft/app/providers/booking_provider.dart';
import 'package:skycraft/app/providers/post_provider.dart';
import 'package:skycraft/app/providers/users_provider.dart';
import 'package:skycraft/app/providers/wallet_provider.dart';
import 'package:skycraft/app/routes/app_pages.dart';

import 'app/providers/auth_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initService();
  runApp(const InitializeApp());
}

Future<void> initService() async {
  log('starting service');
  await Get.putAsync<WalletProvider>(() async => WalletProvider());
  await Get.putAsync<AuthProvider>(() async => AuthProvider());
  await Get.putAsync<UserProvider>(() async => UserProvider());
  await Get.putAsync<BookingProvider>(() async => BookingProvider());
  await Get.putAsync<PostProvider>(() async => PostProvider());
  log('service started');
}

//
class InitializeApp extends StatelessWidget {
  const InitializeApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sky kraft",
      theme: lightTheme(context),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
