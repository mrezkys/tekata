import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tekata/app/routes/app_pages.dart';
import 'package:tekata/app/style/app_color.dart';
import 'package:tekata/app/widgets/dialog/custom_alert_dialog.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        image: DecorationImage(image: AssetImage('assets/images/bggrad.png'), fit: BoxFit.fitWidth),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/profile.svg'),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/notification.svg'),
            ),
          ],
          title: Text(
            'Selamat Bermain!',
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 14,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 24),
              padding: EdgeInsets.symmetric(horizontal: 36),
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Pilih Level",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              height: 84,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                image: DecorationImage(
                  image: AssetImage('assets/images/5kata.png'),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.toNamed(Routes.GAME, arguments: 5);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              height: 84,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                image: DecorationImage(
                  image: AssetImage('assets/images/4kata.png'),
                ),
              ),
              child: InkWell(
                onTap: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              height: 84,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                image: DecorationImage(
                  image: AssetImage('assets/images/3kata.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
