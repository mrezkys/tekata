import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tekata/app/controllers/loading_controller.dart';
import 'package:tekata/app/routes/app_pages.dart';
import 'package:tekata/app/widgets/dialog/custom_alert_dialog.dart';
import 'package:tekata/app/widgets/snackbar/custom_snackbar.dart';

class GameController extends GetxController {
  int level = Get.arguments;
  var loadingController = Get.find<LoadingController>();

  late List<TextEditingController> answerControllers;
  RxList<bool> answerChecked = <bool>[].obs;
  RxList<List<dynamic>> checkResult = List<List<dynamic>>.empty(growable: true).obs;
  RxList<List<FocusNode>> listFocusNode = List<List<FocusNode>>.empty(growable: true).obs;

  String baseUrl = 'https://tekata.herokuapp.com';

  RxString primaryButtonName = 'menyerah'.obs;
  RxString gameResult = 'unknown'.obs;

  void changePrimaryButtonName({bool reset = false}) {
    print('executed');
    if (reset == true) {
      primaryButtonName.value = 'menyerah';
      primaryButtonName.refresh();
      print('menyerah');
    } else {
      primaryButtonName.value = 'lanjut';
      primaryButtonName.refresh();
      print('lanjut');
    }
  }

  Future<void> writeGameResult(int level, String result) async {
    var box = GetStorage();

    gameResult.value = result;

    String totalwin_key = 'level_${level}_total_win';
    var totalwin = box.read(totalwin_key);

    String totalplay_key = 'level_${level}_total_play';
    var totalplay = box.read(totalplay_key);

    String winstreak_key = 'level_${level}_winstreak';
    var winstreak = box.read(winstreak_key);

    if (result == 'lose') {
      await box.write(winstreak_key, 0);
      await box.write(totalplay_key, (totalplay + 1));
    } else {
      if (winstreak == null) {
        await box.write(winstreak_key, 1);
      } else {
        await box.write(winstreak_key, winstreak + 1);
      }
      ;
      if (totalwin == null) await box.write(totalwin_key, (0 + 1));
      if (totalplay == null) await box.write(totalplay_key, (0 + 1));
    }
  }

  Map<String, dynamic> getGameResult(int level) {
    var box = GetStorage();

    String totalwin_key = 'level_${level}_total_win';
    var totalwin = box.read(totalwin_key);

    String totalplay_key = 'level_${level}_total_play';
    var totalplay = box.read(totalplay_key);

    String winstreak_key = 'level_${level}_winstreak';
    var winstreak = box.read(winstreak_key);

    return {
      'played': totalplay,
      'win': totalwin,
      'winstreak': winstreak,
    };
  }

  Future<void> getWord() async {
    try {
      Uri uri = Uri.parse(baseUrl + '/level=$level/word');
      var response = await http.get(uri);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      if (json['status'] == true) {
        print(json['key']);
        final box = GetStorage();
        await box.write('key', json['key']);
      } else {
        Get.snackbar('Error', 'error');
      }
    } catch (e) {
      Get.snackbar('Error', 'error: $e');
    }
  }

  Future<String> getKbbi(String word) async {
    Uri uri = Uri.parse(baseUrl + '/check=$word');
    var response = await http.get(uri);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (json['status'] == true) {
      return json['data'];
    } else {
      return 'error';
    }
  }

  Future<void> checkAnswer({required String answer, required int index}) async {
    final box = GetStorage();
    String key = await box.read('key');
    Uri uri = Uri.parse(baseUrl + '/answer=$answer&key=$key');

    loadingController.isLoading.value = true;

    var response = await http.get(uri);
    var responseBody = response.body;
    var json = jsonDecode(responseBody);

    if (json['status'] == false && json['kbbi'] != null) {
      print('ada di kbbi, jawaban salah');
      checkResult[index].replaceRange(0, (level - 1), json['data']);
      checkResult.refresh();

      answerChecked[index] = true;
      answerChecked.refresh();
      // print(checkResult);
      // print(checkResult[index]);

      loadingController.isLoading.value = false;

      if (index == (level - 1)) {
        loadingController.isLoading.value = true;

        await writeGameResult(level, 'lose');
        changePrimaryButtonName();
        Map<String, dynamic> gameResult = getGameResult(level);
        String kbbi = await getKbbi(key);

        loadingController.isLoading.value = false;
        CustomAlertDialog.gameResult(
          status: 'lose',
          played: gameResult['played'],
          win: gameResult['win'],
          winstreak: gameResult['winstreak'],
          answer: key,
          answerDescription: kbbi,
        );
      }
    } else if (json['status'] == true) {
      //ada di kbbi dan benar jawaban
      if (Get.focusScope != null) Get.focusScope!.unfocus();
      checkResult[index].replaceRange(0, (level - 1), json['data']);
      checkResult.refresh();

      answerChecked.addAll(
        List.generate(level, (index) => true),
      );
      answerChecked.refresh();

      await writeGameResult(level, 'win');
      changePrimaryButtonName();
      Map<String, dynamic> gameResult = getGameResult(level);
      String kbbi = await getKbbi(key);

      loadingController.isLoading.value = false;

      CustomAlertDialog.gameResult(
        status: 'win',
        played: gameResult['played'],
        win: gameResult['win'],
        winstreak: gameResult['winstreak'],
        answer: key,
        answerDescription: kbbi,
      );
    } else {
      //gaada di kbbi, salah jawaban
      loadingController.isLoading.value = false;
      CustomSnackbar.warningSnackbar('Kata Tidak Ditemukan', 'Kata tersebut tidak terdapat di kbbi.');
    }
  }

  Future<void> surrendGame() async {
    loadingController.isLoading.value = true;

    final box = GetStorage();
    String key = await box.read('key');

    answerChecked.addAll(
      List.generate(level, (index) => true),
    );
    answerChecked.refresh();
    await writeGameResult(level, 'lose');

    Map<String, dynamic> gameResult = getGameResult(level);
    String kbbi = await getKbbi(key);

    loadingController.isLoading.value = false;

    CustomAlertDialog.gameResult(
      status: 'lose',
      played: gameResult['played'],
      win: gameResult['win'],
      winstreak: gameResult['winstreak'],
      answer: key,
      answerDescription: kbbi,
    ).then((value) {
      print("closed");
      nextGame();
    });
  }

  nextGame() {}

  initApp() async {
    loadingController.isLoading.value = true;
    answerControllers = List.generate(level, (index) => TextEditingController());
    answerChecked.addAll(
      List.generate(level, (index) => false),
    );
    answerChecked.refresh();

    checkResult.addAll(
      List.generate(level, (index) => List.generate(level, (index) => 'false')),
    );
    checkResult.refresh();

    listFocusNode.addAll(
      List.generate(level, (index) => List.generate(level, (index) => FocusNode())),
    );
    listFocusNode.refresh();
    await getWord();
    loadingController.isLoading.value = false;
    listFocusNode[0][0].requestFocus();
  }

  final count = 0.obs;
  @override
  void onInit() {
    initApp();
    super.onInit();
  }
}
