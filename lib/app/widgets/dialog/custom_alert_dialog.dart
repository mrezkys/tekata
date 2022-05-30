import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tekata/app/style/app_color.dart';
import 'package:tekata/app/widgets/game_result_item.dart';

class CustomAlertDialog {
  static gameResult({
    required String status,
    required int played,
    required int win,
    required int winstreak,
    required String answer,
    required String answerDescription,
  }) {
    return Get.defaultDialog(
      title: '',
      contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
      radius: 16,
      titlePadding: EdgeInsets.zero,
      titleStyle: TextStyle(fontSize: 0),
      backgroundColor: Colors.white,
      content: StatefulBuilder(
        builder: ((context, setState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: (status == 'win') ? Image.asset('assets/images/menang.png') : Image.asset('assets/images/kalah.png'),
                    margin: EdgeInsets.only(bottom: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameResultItem(
                      number: played,
                      title: 'Dimainkan',
                    ),
                    GameResultItem(
                      number: win,
                      title: 'Menang',
                    ),
                    GameResultItem(
                      number: winstreak,
                      title: 'Beruntun',
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: 36),
                  height: 200,
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jawaban : $answer',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text('${answerDescription}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      primary: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'share',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.share_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
