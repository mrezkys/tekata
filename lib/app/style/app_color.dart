import 'package:flutter/cupertino.dart';

class AppColor {
  static Color primary = Color(0xFF0B93CF);
  static Color primaryAccent = Color(0xFF0E61AA);
  static Gradient primaryGradient = LinearGradient(
    colors: [primary, primaryAccent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primaryDark = Color(0xFF0B6FAA);
  static Color primaryExtraDark = Color(0xFF064665);

  static Color secondary = Color(0xFFF8B826);
  static Color secondaryAccent = Color(0xFFF89400);
  static Gradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryAccent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color error = Color(0xFFD00E0E);
  static Color success = Color(0xFF16AE26);
  static Color warning = Color(0xFFEB8600);
}
