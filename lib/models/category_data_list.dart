class CategoryDataList {
  List<CategoryData> data;

  CategoryDataList({this.data});

  CategoryDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CategoryData>();
      json['data'].forEach((v) {
        data.add(new CategoryData.fromJson(v));
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

class CategoryData {
  int cid;
  String name;
  List<ChildCategory> childCategory;

  CategoryData({this.cid, this.name, this.childCategory});

  CategoryData.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    if (json['child_category'] != null) {
      childCategory = new List<ChildCategory>();
      json['child_category'].forEach((v) {
        childCategory.add(new ChildCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> CategoryData = new Map<String, dynamic>();
    CategoryData['cid'] = this.cid;
    CategoryData['name'] = this.name;
    if (this.childCategory != null) {
      CategoryData['child_category'] =
          this.childCategory.map((v) => v.toJson()).toList();
    }
    return CategoryData;
  }
}

class ChildCategory {
  int cid;
  String name;

  ChildCategory({this.cid, this.name});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['name'] = this.name;
    return data;
  }
}