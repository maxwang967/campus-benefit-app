class ShortUrl {
  String err;
  String url;

  ShortUrl({this.err, this.url});

  ShortUrl.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['err'] = this.err;
    data['url'] = this.url;
    return data;
  }
}
