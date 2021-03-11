class CourseDataList {
  List<Products> products;
  String limit;

  CourseDataList({this.products, this.limit});

  CourseDataList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    return data;
  }
}

class Products {
  String name;
  List<Value> value;
  String order_url;
  String guide_url;
  Products({this.name, this.value});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['value'] != null) {
      value = new List<Value>();
      json['value'].forEach((v) {
        value.add(new Value.fromJson(v));
      });
    }
    order_url = json['order_url'];
    guide_url = json['guide_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['order_url'] = this.order_url;
    data['guide_url'] = this.guide_url;
    if (this.value != null) {
      data['value'] = this.value.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String name;
  var currentPrice;
  String id;

  Value(
      {this.name,
      this.currentPrice,
      this.id});

  Value.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currentPrice = json['current_price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['current_price'] = this.currentPrice;
    data['id'] = this.id;
    return data;
  }
}
