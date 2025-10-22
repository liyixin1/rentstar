/// id : 1
/// title : "精品装修"
/// subtitle : "舒适的环境"
/// resid : 1
/// imgurl : "https://n.sinaimg.cn/sinacn16/112/w1557h955/20180510/7270-haichqz7292785.jpg"
/// link : "https://www.baidu.com"
/// type : 0
/// status : 0

///首页本期优选数据列表
class HomeBetterChoiceListData {
  List<HomeBetterChoiceData>? choiceList;

  HomeBetterChoiceListData.fromJson(dynamic json) {
    choiceList = [];
    if (json is List) {
      // 直接是列表数据
      for (var child in json) {
        choiceList?.add(HomeBetterChoiceData.fromJson(child));
      }
    } else if (json is Map<String, dynamic>) {
      // 是一个包含列表的 JSON 对象，尝试获取其中的列表数据
      // 先尝试从 data 字段获取，再尝试从 content 字节获取（根据实际返回的数据结构）
      dynamic data = json['data'];
      if (data == null) {
        data = json['content'];
      }
      
      if (data is List) {
        for (var child in data) {
          choiceList?.add(HomeBetterChoiceData.fromJson(child));
        }
      }
    }
  }
}

class HomeBetterChoiceData {
  HomeBetterChoiceData({
    this.id,
    this.title,
    this.subtitle,
    this.resid,
    this.imgurl,
    this.link,
    this.type,
    this.status,
  });

  HomeBetterChoiceData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    resid = json['resid'];
    imgurl = json['imgurl'];
    link = json['link'];
    type = json['type'];
    status = json['status'];
  }

  num? id;
  String? title;
  String? subtitle;
  num? resid;
  String? imgurl;
  String? link;
  num? type;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['resid'] = resid;
    map['imgurl'] = imgurl;
    map['link'] = link;
    map['type'] = type;
    map['status'] = status;
    return map;
  }
}