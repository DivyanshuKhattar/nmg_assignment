import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmg_assignment/Resources/color_picker.dart';

class CustomStyle {

/*
Note:
  Regular = fontWeight.400
  Normal = fontWeight.500
  SemiBold = fontWeight.600
  Bold = fontWeight.700
*/


  /// ************************ [12 pixel text] *************************

  // 12 Normal black text style
  static final twelveNormalBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: blackColor,
    ),
  );

  /// ************************ [14 pixel text] *************************

  // 14 SemiBold black text style
  static final fourteenSemiBoldBlackText = GoogleFonts.montserrat(
    textStyle: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: blackColor,
    ),
  );

}