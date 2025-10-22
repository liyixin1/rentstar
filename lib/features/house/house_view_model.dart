import 'package:flutter/foundation.dart';
import 'package:rentstar/core/repository/house_repository.dart';

class HouseListViewModel extends ChangeNotifier {
  final HouseRepository _repository = HouseRepository();
  
  List<House> _houses = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getter 方法
  List<House> get houses => _houses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  /// 加载房源列表
  Future<void> loadHouses({int page = 1, int limit = 10}) async {
    if (_isLoading) return;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final houses = await _repository.getHouses(page: page, limit: limit);
      _houses = houses;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// 搜索房源
  Future<void> searchHouses(String keyword) async {
    if (_isLoading) return;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final houses = await _repository.searchHouses(keyword);
      _houses = houses;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class HouseDetailViewModel extends ChangeNotifier {
  final HouseRepository _repository = HouseRepository();
  
  House? _house;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getter 方法
  House? get house => _house;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  
  /// 加载房源详情
  Future<void> loadHouseDetail(int houseId) async {
    if (_isLoading) return;
    
    _isLoading = true;
    _errorMessage = null;
    _house = null;
    notifyListeners();
    
    try {
      final house = await _repository.getHouseById(houseId);
      _house = house;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}