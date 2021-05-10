import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final kPrimaryColor = Theme.of(Get.context).primaryColor;
final kSecondaryColor = Theme.of(Get.context).accentColor;
final kButtonColor = Theme.of(Get.context).buttonColor;

final kInterText = GoogleFonts.inter(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.normal,
);

Widget button({
  String buttonTxt,
  VoidCallback onTap,
  Color buttonColor,
  Color txtColor,
  double txtSize,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Text(
            buttonTxt,
            style: kInterText.copyWith(
              fontSize: txtSize,
              color: txtColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}
