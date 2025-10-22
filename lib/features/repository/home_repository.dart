import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rentstar/core/http/dio.instance.dart';
import 'package:rentstar/features/repository/model/home_banner_model.dart';
import 'package:rentstar/features/repository/model/home_betterchoice_model.dart';

class HomeRepository{
  HomeRepository._();

  static HomeRepository api = HomeRepository._();

  Future<HomeBannerListData> getHomeBanner() async {
    try {
      Response response = await DioInstance.instance().post(path: "/banner/bannerList");
      return HomeBannerListData.fromJson(response.data);
    } catch (e) {
      log("获取Banner数据异常: $e");
      return HomeBannerListData.fromJson([]); // 返回空数据而不是抛出异常
    }
  }
  
  Future<HomeBetterChoiceListData> getHomeBetterChoice() async {
    try {
      Response response = await DioInstance.instance().post(path: "/betterChoice/choiceList");
      return HomeBetterChoiceListData.fromJson(response.data);
    } catch (e) {
      log("获取BetterChoice数据异常: $e");
      return HomeBetterChoiceListData.fromJson([]); // 返回空数据而不是抛出异常
    }
  }
}