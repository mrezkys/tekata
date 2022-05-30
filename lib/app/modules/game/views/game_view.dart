import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tekata/app/style/app_color.dart';
import 'package:tekata/app/widgets/loading.dart';
import 'package:tekata/app/widgets/pin.dart';

import '../controllers/game_controller.dart';

class GameView extends GetView<GameController> {
  final int level = Get.arguments;
  final TextEditingController textaja = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColor.primaryGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset('assets/icons/arrow-left.svg'),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/info.svg'),
              ),
            ],
            title: Text(
              'Tebak Kata Level $level',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 14,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      controller.level,
                      (index) {
                        return Obx(() {
                          print('rebuild');
                          return Pin(
                            itemCount: controller.level,
                            itemHeight: 64,
                            itemWidth: 64,
                            listFocusNode: controller.listFocusNode,
                            controller: controller.answerControllers[index],
                            checked: controller.answerChecked[index],
                            check: controller.checkResult[index],
                            index: index,
                            onFinished: () async {
                              await controller.checkAnswer(
                                answer: controller.answerControllers[index].text,
                                index: index,
                              );
                              if (controller.answerChecked[index] == true) {
                                if (index < (controller.level - 1)) {
                                  controller.listFocusNode[((index) + 1)][0].requestFocus();
                                }
                              }
                            },
                          );
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      margin: EdgeInsets.only(right: 16),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: SvgPicture.asset('assets/icons/star.svg'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          primary: AppColor.primary,
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: AppColor.secondaryGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            print(controller.primaryButtonName);
                          },
                          borderRadius: BorderRadius.circular(8),
                          highlightColor: Colors.black.withOpacity(0.1),
                          splashColor: Colors.black.withOpacity(0.1),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            height: 64,
                            child: Obx(
                              () => Text(
                                controller.primaryButtonName.value,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
