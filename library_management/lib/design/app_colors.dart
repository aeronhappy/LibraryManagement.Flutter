import 'package:flutter/material.dart';

/// App Colory

Color primaryColor = const Color(0xff66BB6C);
Color navBarIconColor = const Color(0xffC2C2C2);
Color successColor = const Color(0xffD9F7BE);
Color errorColor = const Color(0xffc62828);

Color onlineColor = const Color(0xff3BD032);
Color facebookColor = const Color(0xff0866FF);
Color gmailColor = const Color(0xffE53935);

// ///TransparentColor
// Color transparentBlackColor = const Color(0xff7e000000);
// Color transparentWhiteColor = const Color(0xff7effffff);

Color lightBgColor = Color(0xFFF5F5F5);
Color lightCardColor = Colors.white;
Color lightTextColor = const Color(0xff1D1D1F);

Color darkBgColor = Color(0xFF121212);
Color darkCardColor = Color(0xFF1E1E1E);
Color darkTextColor = const Color(0xffFFFFFF);

LinearGradient gradientColor(Color color1, Color color2) {
  return LinearGradient(
    colors: [color1, color2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

LinearGradient gradientColorHorizontal(Color color1, Color color2) {
  return LinearGradient(
    colors: [color1, color2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

Widget sliderTheme(Widget slider, BuildContext context) {
  return SliderTheme(
    data: SliderTheme.of(context).copyWith(
      trackHeight: 2.5,
      thumbColor: Theme.of(context).primaryColor,
      activeTrackColor: Theme.of(context).primaryColor,
      inactiveTrackColor: Theme.of(context).highlightColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 3),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
      tickMarkShape: RoundSliderTickMarkShape(),
    ),
    child: slider,
  );
}
