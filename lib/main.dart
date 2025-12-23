import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'const/firebase_constants.dart';
import 'controllers/authentication_controller.dart';
import 'data/providers/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? FirebaseConstants.android
        : FirebaseConstants.ios,
  );

  Get.put(AuthController());
  Get.put(DioClient());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIF Application',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFC107),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFC107)),
        useMaterial3: true,
      ),
      home: const Center(child: CircularProgressIndicator()),
    );
  }
}