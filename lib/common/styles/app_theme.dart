// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:sample_shop/common/helpers/constants/colors_constants.dart';

final ThemeData appTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(color: kDefaultTextColor),
      bodyText2: TextStyle(color: kDefaultTextColor)),
  // Colors Scheme
  primarySwatch: kPrimaryColor,
  appBarTheme: const AppBarTheme(backgroundColor: kAppAndNavBarColor),
  scaffoldBackgroundColor: kBackGroundColor,
  backgroundColor: kBackGroundColor,
  hintColor: kDefaultBorderColor
);
