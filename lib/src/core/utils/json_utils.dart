import 'dart:convert';

import 'package:flutter/services.dart';

class JsonUtils {
  static Future<Map<String, dynamic>> readJsonFromAssets(String path) async {
    final String response = await rootBundle.loadString(
      path,
    );
    final Map<String, dynamic> data = await jsonDecode(response);
    return data;
  }
}
