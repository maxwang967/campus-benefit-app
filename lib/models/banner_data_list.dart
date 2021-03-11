class BannerDataList {
  List<BannerData> data;

  BannerDataList({this.data});

  BannerDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BannerData>();
      json['data'].forEach((v) {
        data.add(new BannerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerData {
  String image;
  String name;
  String url;

  BannerData({this.image, this.name, this.url});

  BannerData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

