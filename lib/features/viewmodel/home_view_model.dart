import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:rentstar/core/utils/json/json_model.dart';
import 'package:rentstar/core/utils/json/json_util.dart';
import 'package:rentstar/features/repository/home_repository.dart';
import 'package:rentstar/features/repository/model/home_banner_model.dart';
import 'package:rentstar/features/repository/model/home_betterchoice_model.dart';

class HomeViewModel with ChangeNotifier{
  List<HomeBannerData>? banner;
  List<HomeBetterChoiceData>? betterChoice;
  // 城市数据
  List<RegionData> cities = [];
  String currentCity = "北京";
  List<String> currentDistricts = [];

  Future initData() async {
    try{
      final data = await JsonUtil.loadJsonListFromAssets('assets/data/ca.json');
      for(var group in data){
        for(var item in group){
          if(item is Map<String,dynamic>){
            cities.add(RegionData.fromJson(item));
          }
        }
      }
      getHomeBanner();
      getHomeBetterChoice();
      getCurrentCityData(currentCity);
      notifyListeners();
    }catch(e){
      log("initData发生错误：$e");
    }
  }

  Future getHomeBanner() async {
    try {
      HomeBannerListData data = await HomeRepository.api.getHomeBanner();
      banner = data.bannerList ?? []; // 确保始终赋值
    } catch (e) {
      log("获取Banner数据失败: $e");
      banner = []; // 发生错误时设置为空列表而不是null
    }
  }
  
  List<String?> generalBannerList(List<HomeBannerData>? banner) {
    List<String?> b = [];
    banner?.forEach((element) {
      b.add(element.imgurl);
    });
    return b;
  }

  Future getHomeBetterChoice() async {
    try {
      HomeBetterChoiceListData data = await HomeRepository.api.getHomeBetterChoice();
      betterChoice = data.choiceList ?? [];
    } catch (e) {
      log("获取BetterChoice数据失败: $e");
      betterChoice = []; // 发生错误时设置为空列表而不是null
    }
    notifyListeners();
  }
  
  HomeBetterChoiceData? generalBetterChoiceData(int index) {
    try {
      if (betterChoice != null && (betterChoice?.length ?? 0) >= 3) {
        log("data:${betterChoice?[index]}");
        return betterChoice?[index];
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  getCurrentCityData(String city){
    for(var item in cities){
      if(item.regionName == city){
        currentDistricts = item.districts;
      }
    }
    notifyListeners();
  }


}