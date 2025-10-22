import 'dart:convert';

import 'package:flutter/services.dart';

class JsonUtil{
  static Future<List<dynamic>> loadJsonListFromAssets(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      return _parseJsonList(data);
    } catch (e) {
      throw Exception('Failed to load JSON from assets: $e');
    }
  }
  static Future<List<dynamic>> readCAData() async {
    try {
      // 从 assets 中读取文件内容
      final String jsonString = await rootBundle.loadString('assets/data/ca.json');

      // 解析 JSON 数据
      final dynamic jsonResult = jsonDecode(jsonString);

      // 确保数据是 List 类型
      if (jsonResult is List) {
        return jsonResult;
      } else {
        throw Exception('JSON 数据格式不正确，期望是一个数组');
      }
    } catch (e) {
      throw Exception('读取或解析 ca.json 文件时出错: $e');
    }
  }

  /// 解析 JSON 字符串
  static List<dynamic> _parseJsonList(String jsonString) {
    try {
      final jsonData = jsonDecode(jsonString);
      
      // 如果是直接的列表数据
      if (jsonData is List) {
        return jsonData.cast<dynamic>();
      }
      
      // 如果是包含在对象中的列表数据（例如 {"data": [...]}）
      if (jsonData is Map<String, dynamic> && jsonData['data'] is List) {
        return (jsonData['data'] as List).cast<dynamic>();
      }
      
      // 如果无法解析为列表，则抛出异常
      throw FormatException('JSON is not a list or does not contain a "data" list field');
    } on FormatException catch (e) {
      throw FormatException('JSON format error: ${e.message}');
    }
  }
}