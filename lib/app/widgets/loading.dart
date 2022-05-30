import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekata/app/controllers/loading_controller.dart';
import 'package:tekata/app/style/app_color.dart';

class Loading extends GetView<LoadingController> {
  final Widget child;
  Loading({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      Obx(
        () => Visibility(
          visible: controller.isLoading.value,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CircularProgressIndicator(
                      color: AppColor.secondary,
                      strokeWidth: 4,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
