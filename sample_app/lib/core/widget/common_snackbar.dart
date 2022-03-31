import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommanSnackbar {
  static void showPositiveSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.white, colorText: Colors.black);
  }
}
