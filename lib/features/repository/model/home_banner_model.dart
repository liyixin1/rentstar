/// id : 1
/// imgurl : "https://q7.itc.cn/images01/20240312/ae5f3266aeb6408db22ad354f1168883.jpeg"
/// link : "https://www.baidu.com"
/// type : 0
/// activename : "搞笑活动"
/// status : 0

///首页banner数据列表
class HomeBannerListData {
  List<HomeBannerData>? bannerList;

  HomeBannerListData.fromJson(dynamic json) {
    bannerList = [];
    if (json is List) {
      // 直接是列表数据
      for (var child in json) {
        bannerList?.add(HomeBannerData.fromJson(child));
      }
    } else if (json is Map<String, dynamic>) {
      // 是一个包含列表的 JSON 对象，尝试获取其中的列表数据
      // 先尝试从 data 字段获取，再尝试从 content 字节获取（根据实际返回的数据结构）
      dynamic data = json['data'];
      data ??= json['content'];
      
      if (data is List) {
        for (var child in data) {
          bannerList?.add(HomeBannerData.fromJson(child));
        }
      }
    }
  }
}

class HomeBannerData {
  HomeBannerData({
    this.id,
    this.imgurl,
    this.link,
    this.type,
    this.activename,
    this.status,
  });

  HomeBannerData.fromJson(dynamic json) {
    id = json['id'];
    imgurl = json['imgurl'];
    link = json['link'];
    type = json['type'];
    activename = json['activename'];
    status = json['status'];
  }

  num? id;
  String? imgurl;
  String? link;
  num? type;
  String? activename;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['imgurl'] = imgurl;
    map['link'] = link;
    map['type'] = type;
    map['activename'] = activename;
    map['status'] = status;
    return map;
  }
}