import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tekata/app/controllers/loading_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(LoadingController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'poppins',
      ),
      getPages: AppPages.routes,
    ),
  );
}
