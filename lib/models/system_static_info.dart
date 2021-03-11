class SystemStaticInfo {
  HomePageData homePageData;
  CoursePageData coursePageData;
  MyPageData myPageData;

  SystemStaticInfo({this.homePageData, this.coursePageData, this.myPageData});

  SystemStaticInfo.fromJson(Map<String, dynamic> json) {
    homePageData = json['home_page_data'] != null
        ? new HomePageData.fromJson(json['home_page_data'])
        : null;
    coursePageData = json['course_page_data'] != null
        ? new CoursePageData.fromJson(json['course_page_data'])
        : null;
    myPageData = json['my_page_data'] != null
        ? new MyPageData.fromJson(json['my_page_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homePageData != null) {
      data['home_page_data'] = this.homePageData.toJson();
    }
    if (this.coursePageData != null) {
      data['course_page_data'] = this.coursePageData.toJson();
    }
    if (this.myPageData != null) {
      data['my_page_data'] = this.myPageData.toJson();
    }
    return data;
  }
}

class HomePageData {
  List<SwiperPage> swiperPage;
  List<CateTypes> cateTypes;
  String pwaUrl;

  HomePageData({this.swiperPage, this.cateTypes, this.pwaUrl});

  HomePageData.fromJson(Map<String, dynamic> json) {
    if (json['swiper_page'] != null) {
      swiperPage = new List<SwiperPage>();
      json['swiper_page'].forEach((v) {
        swiperPage.add(new SwiperPage.fromJson(v));
      });
    }
    if (json['cate_types'] != null) {
      cateTypes = new List<CateTypes>();
      json['cate_types'].forEach((v) {
        cateTypes.add(new CateTypes.fromJson(v));
      });
    }
        pwaUrl = json['pwa_url'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swiperPage != null) {
      data['swiper_page'] = this.swiperPage.map((v) => v.toJson()).toList();
    }
    if (this.cateTypes != null) {
      data['cate_types'] = this.cateTypes.map((v) => v.toJson()).toList();
    }
        data['pwa_url'] = this.pwaUrl;

    return data;
  }
}

class SwiperPage {
  String url;
  String nav;
  bool isWeb;
  String name;

  SwiperPage({this.url, this.nav, this.isWeb, this.name});

  SwiperPage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    nav = json['nav'];
    isWeb = json['is_web'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['nav'] = this.nav;
    data['is_web'] = this.isWeb;
    data['name'] = this.name;
    return data;
  }
}

class CateTypes {
  String name;
  String image;
  String nav;
  bool isWeb;

  CateTypes({this.name, this.image, this.nav, this.isWeb});

  CateTypes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    nav = json['nav'];
    isWeb = json['is_web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['nav'] = this.nav;
    data['is_web'] = this.isWeb;
    return data;
  }
}

class CardPage {
  String name;
  String url;
  String nav;
  bool isWeb;

  CardPage({this.name, this.url, this.nav, this.isWeb});

  CardPage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    nav = json['nav'];
    isWeb = json['is_web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['nav'] = this.nav;
    data['is_web'] = this.isWeb;
    return data;
  }
}

class CoursePageData {
  List<CardPage> cardPage;
  CoursePageData({this.cardPage});
  String n97_order_url;
  String vip_order_url;
  String ak_order_url;
  String n97_guide_url;
  String ak_guide_url;
  String vip_guide_url;
  CoursePageData.fromJson(Map<String, dynamic> json) {
    if (json['card_page'] != null) {
      cardPage = new List<CardPage>();
      json['card_page'].forEach((v) {
        cardPage.add(new CardPage.fromJson(v));
      });
    }
    n97_order_url = json['n97_order_url'];
    vip_order_url = json['vip_order_url'];
    ak_order_url = json['ak_order_url'];
    n97_guide_url = json['n97_guide_url'];
    ak_guide_url = json['ak_guide_url'];
    vip_guide_url = json['vip_guide_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardPage != null) {
      data['card_page'] = this.cardPage.map((v) => v.toJson()).toList();
    }
    data['n97_order_url']=n97_order_url;
    data['vip_order_url']=vip_order_url;
    data['ak_order_url']=ak_order_url;
    data['n97_guide_url']=n97_guide_url;
    data['ak_guide_url']=ak_guide_url;
    data['vip_guide_url']=vip_guide_url;
    return data;
  }
}

class MyPageData {
  DistributionPage distributionPage;
  MoneyPage moneyPage;
  SubstationPage substationPage;
  String website;
  CantactUsPage cantactUsPage;
  VipPage vipPage;
  Share share;
  String point;
  String headImg;
  List<CardPage> cardPage;
  MyPageData(
      {this.distributionPage,
      this.moneyPage,
      this.substationPage,
      this.website,
      this.cantactUsPage,
      this.vipPage,
      this.share,
      this.point,
      this.headImg,
      this.cardPage});

  MyPageData.fromJson(Map<String, dynamic> json) {
    if (json['card_page'] != null) {
      cardPage = new List<CardPage>();
      json['card_page'].forEach((v) {
        cardPage.add(new CardPage.fromJson(v));
      });
    }
    distributionPage = json['distribution_page'] != null
        ? new DistributionPage.fromJson(json['distribution_page'])
        : null;
    moneyPage = json['money_page'] != null
        ? new MoneyPage.fromJson(json['money_page'])
        : null;
    substationPage = json['substation_page'] != null
        ? new SubstationPage.fromJson(json['substation_page'])
        : null;
    website = json['website'];
    point = json['point'];
    headImg = json['head_img'];
    cantactUsPage = json['cantact_us_page'] != null
        ? new CantactUsPage.fromJson(json['cantact_us_page'])
        : null;
    vipPage = json['vip_page'] != null
        ? new VipPage.fromJson(json['vip_page'])
        : null;
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardPage != null) {
      data['card_page'] = this.cardPage.map((v) => v.toJson()).toList();
    }
    if (this.distributionPage != null) {
      data['distribution_page'] = this.distributionPage.toJson();
    }
    if (this.moneyPage != null) {
      data['money_page'] = this.moneyPage.toJson();
    }
    if (this.substationPage != null) {
      data['substation_page'] = this.substationPage.toJson();
    }
    data['website'] = this.website;
    data['point'] = this.point;
    data['head_img'] = this.headImg;
    if (this.cantactUsPage != null) {
      data['cantact_us_page'] = this.cantactUsPage.toJson();
    }
    if (this.vipPage != null) {
      data['vip_page'] = this.vipPage.toJson();
    }
    if (this.share != null) {
      data['share'] = this.share.toJson();
    }

    return data;
  }
}

class DistributionPage {
  List<Hint> hint;

  DistributionPage({this.hint});

  DistributionPage.fromJson(Map<String, dynamic> json) {
    if (json['hint'] != null) {
      hint = new List<Hint>();
      json['hint'].forEach((v) {
        hint.add(new Hint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hint != null) {
      data['hint'] = this.hint.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hint {
  String title;
  String subtitle;
  String content;

  Hint({this.title, this.subtitle, this.content});

  Hint.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['content'] = this.content;
    return data;
  }
}

class MoneyPage {
  List<Hint> hint;
  List<int> rechargeFinerCodeRange;
  List<int> withdrawFinerCodeRange;

  MoneyPage(
      {this.hint, this.rechargeFinerCodeRange, this.withdrawFinerCodeRange});

  MoneyPage.fromJson(Map<String, dynamic> json) {
    if (json['hint'] != null) {
      hint = new List<Hint>();
      json['hint'].forEach((v) {
        hint.add(new Hint.fromJson(v));
      });
    }
    rechargeFinerCodeRange = json['recharge_finer_code_range'].cast<int>();
    withdrawFinerCodeRange = json['withdraw_finer_code_range'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hint != null) {
      data['hint'] = this.hint.map((v) => v.toJson()).toList();
    }
    data['recharge_finer_code_range'] = this.rechargeFinerCodeRange;
    data['withdraw_finer_code_range'] = this.withdrawFinerCodeRange;
    return data;
  }
}

class SubstationPage {
  List<Hint> hint;
  Share share;

  SubstationPage({this.hint, this.share});

  SubstationPage.fromJson(Map<String, dynamic> json) {
    if (json['hint'] != null) {
      hint = new List<Hint>();
      json['hint'].forEach((v) {
        hint.add(new Hint.fromJson(v));
      });
    }
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hint != null) {
      data['hint'] = this.hint.map((v) => v.toJson()).toList();
    }
    if (this.share != null) {
      data['share'] = this.share.toJson();
    }
    return data;
  }
}

class Share {
  String url;
  String title;
  String content;

  Share({this.url, this.title, this.content});

  Share.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class CantactUsPage {
  String qqQun;
  List<Cantact> cantact;

  CantactUsPage({this.qqQun, this.cantact});

  CantactUsPage.fromJson(Map<String, dynamic> json) {
    qqQun = json['qq_qun'];
    if (json['cantact'] != null) {
      cantact = new List<Cantact>();
      json['cantact'].forEach((v) {
        cantact.add(new Cantact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qq_qun'] = this.qqQun;
    if (this.cantact != null) {
      data['cantact'] = this.cantact.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cantact {
  String name;
  String qq;

  Cantact({this.name, this.qq});

  Cantact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qq = json['qq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qq'] = this.qq;
    return data;
  }
}

class VipPage {
  int vipPrice;
  int beforeVipPrice;
  int yearVipPrice;
  int beforeYearVipPrice;
  List<Hint> hint;

  VipPage(
      {this.vipPrice,
      this.beforeVipPrice,
      this.yearVipPrice,
      this.beforeYearVipPrice,
      this.hint});

  VipPage.fromJson(Map<String, dynamic> json) {
    vipPrice = json['vip_price'];
    beforeVipPrice = json['before_vip_price'];
    yearVipPrice = json['year_vip_price'];
    beforeYearVipPrice = json['before_year_vip_price'];
    if (json['hint'] != null) {
      hint = new List<Hint>();
      json['hint'].forEach((v) {
        hint.add(new Hint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vip_price'] = this.vipPrice;
    data['before_vip_price'] = this.beforeVipPrice;
    data['year_vip_price'] = this.yearVipPrice;
    data['before_year_vip_price'] = this.beforeYearVipPrice;
    if (this.hint != null) {
      data['hint'] = this.hint.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
