import 'package:advance_mvvm/presentation/resources/color_manager.dart';
import 'package:advance_mvvm/presentation/resources/font_manger.dart';
import 'package:advance_mvvm/presentation/resources/style_manger.dart';
import 'package:advance_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      colorScheme: ColorScheme(
        secondary: ColorManager.grey,
        brightness: Brightness.light,
        primary: ColorManager.primary,
        onPrimary: ColorManager.primaryOpacity70,
        onSecondary: ColorManager.primaryOpacity70,
        error: ColorManager.error,
        onError: ColorManager.error,
        surface: ColorManager.white,
        onSurface: ColorManager.black,
      ),
      splashColor: ColorManager.primaryOpacity70,

      //Card View Theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        surfaceTintColor: ColorManager.grey,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),

      //AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
      ),
      //Button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
      ),
      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
        ),
      ),
      //Text theme
      textTheme: TextTheme(
        headlineSmall: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headlineMedium: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
        headlineLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey),
      ),

      //input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: (ColorManager.grey1)),
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      ));
}
