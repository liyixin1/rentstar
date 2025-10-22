import 'package:flutter/material.dart';
import 'package:rentstar/core/http/dio.instance.dart';
import 'package:rentstar/features/pages/home/city_selector_page.dart';

import 'app.dart';

void main() {
  DioInstance.instance().initDio(baseUrl: "http://124.71.112.235:9900");
  runApp(const MyApp());
}

