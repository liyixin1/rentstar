import 'package:rentstar/core/http/dio.instance.dart';

/// 用户数据类
class User {
  final int id;
  final String name;
  final String email;
  final String avatarUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }
}

/// 用户仓库 - 展示如何结合网络和本地数据
class UserRepository {
  final DioInstance _dio = DioInstance.instance();
  
  // 模拟本地数据库存储
  final Map<int, User> _localCache = {};
  
  /// 获取用户信息（先从缓存获取，再从网络获取）
  Future<User> getUser(int userId) async {
    // 首先检查本地缓存
    User? cachedUser = _localCache[userId];
    if (cachedUser != null) {
      // 可以先返回缓存数据，然后在后台更新
      _fetchUserFromNetwork(userId);
      return cachedUser;
    }
    
    // 如果缓存中没有，则从网络获取
    return await _fetchUserFromNetwork(userId);
  }
  
  /// 从网络获取用户信息
  Future<User> _fetchUserFromNetwork(int userId) async {
    try {
      final response = await _dio.get(path: '/users/$userId');
      
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data as Map<String, dynamic>);
        // 更新本地缓存
        _localCache[userId] = user;
        return user;
      } else {
        throw Exception('Failed to load user: ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
  
  /// 更新用户信息
  Future<User> updateUser(User user) async {
    try {
      final response = await _dio.post(
        path: '/users/${user.id}',
        data: user.toJson(),
      );
      
      if (response.statusCode == 200) {
        final updatedUser = User.fromJson(response.data as Map<String, dynamic>);
        // 更新本地缓存
        _localCache[user.id] = updatedUser;
        return updatedUser;
      } else {
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
  
  /// 清除用户缓存
  void clearCache(int userId) {
    _localCache.remove(userId);
  }
  
  /// 清除所有缓存
  void clearAllCache() {
    _localCache.clear();
  }
}