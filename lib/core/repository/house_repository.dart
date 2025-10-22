import 'package:rentstar/core/http/dio.instance.dart';

/// 房源信息数据类
class House {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  House({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}

/// 房源仓库 - 负责处理房源相关数据
class HouseRepository {
  final DioInstance _dio = DioInstance.instance();
  
  /// 获取房源列表
  Future<List<House>> getHouses({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get(
        path: '/houses',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['houses'];
        return data.map((item) => House.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load houses: ${response.statusMessage}');
      }
    } catch (e) {
      // 可以在这里添加错误日志记录
      rethrow;
    }
  }
  
  /// 根据ID获取房源详情
  Future<House> getHouseById(int id) async {
    try {
      final response = await _dio.get(path: '/houses/$id');
      
      if (response.statusCode == 200) {
        return House.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load house details: ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
  
  /// 搜索房源
  Future<List<House>> searchHouses(String keyword) async {
    try {
      final response = await _dio.get(
        path: '/houses/search',
        queryParameters: {'keyword': keyword},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        return data.map((item) => House.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to search houses: ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
}