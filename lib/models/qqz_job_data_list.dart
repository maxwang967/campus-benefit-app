class JobQQZDataList {
  int state;
  String msg;
  String gourl;
  List<JobQQZData> data;

  JobQQZDataList({this.state, this.msg, this.gourl, this.data});

  JobQQZDataList.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    msg = json['msg'];
    gourl = json['gourl'];
    if (json['reward_list'] != null) {
      data = new List<JobQQZData>();
      json['reward_list'].forEach((v) {
        data.add(new JobQQZData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['msg'] = this.msg;
    data['gourl'] = this.gourl;
    if (this.data != null) {
      data['reward_list'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobQQZData {
  String rewardId;
  String rewardTitle;
  String applyPrice;
  String totalVotes;
  String surplusVotes;
  String device;
  String avatar;
  String catName;
  String catCode;
  String catId;
  String tagsName;
  String tagsId;
  String redpacketsId;
  String surplusNumber;
  String browseId;
  String isTop;
  String topEndTime;
  String views;
  String topUpdate;
  String deposit;
  String act;
  String rewardUri;
  String rewardUrl;
  String catUri;
  String catUrl;
  String phone;
  String nickname;
  String catType;

  JobQQZData(
      {this.rewardId,
        this.rewardTitle,
        this.applyPrice,
        this.totalVotes,
        this.surplusVotes,
        this.device,
        this.avatar,
        this.catName,
        this.catCode,
        this.catId,
        this.tagsName,
        this.tagsId,
        this.redpacketsId,
        this.surplusNumber,
        this.browseId,
        this.isTop,
        this.topEndTime,
        this.views,
        this.topUpdate,
        this.deposit,
        this.act,
        this.rewardUri,
        this.rewardUrl,
        this.catUri,
        this.catUrl,
        this.phone,
        this.nickname,
        this.catType});

  JobQQZData.fromJson(Map<String, dynamic> json) {
    rewardId = json['reward_id'];
    rewardTitle = json['reward_title'];
    applyPrice = json['apply_price'];
    totalVotes = json['total_votes'];
    surplusVotes = json['surplus_votes'];
    device = json['device'];
    avatar = json['avatar'];
    catName = json['cat_name'];
    catCode = json['cat_code'];
    catId = json['cat_id'];
    tagsName = json['tags_name'];
    tagsId = json['tags_id'];
    redpacketsId = json['redpackets_id'];
    surplusNumber = json['surplus_number'];
    browseId = json['browse_id'];
    isTop = json['is_top'];
    topEndTime = json['top_end_time'];
    views = json['views'];
    topUpdate = json['top_update'];
    deposit = json['deposit'];
    act = json['act'];
    rewardUri = json['reward_uri'];
    rewardUrl = json['reward_url'];
    catUri = json['cat_uri'];
    catUrl = json['cat_url'];
    phone = json['phone'];
    nickname = json['nickname'];
    catType = json['cat_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reward_id'] = this.rewardId;
    data['reward_title'] = this.rewardTitle;
    data['apply_price'] = this.applyPrice;
    data['total_votes'] = this.totalVotes;
    data['surplus_votes'] = this.surplusVotes;
    data['device'] = this.device;
    data['avatar'] = this.avatar;
    data['cat_name'] = this.catName;
    data['cat_code'] = this.catCode;
    data['cat_id'] = this.catId;
    data['tags_name'] = this.tagsName;
    data['tags_id'] = this.tagsId;
    data['redpackets_id'] = this.redpacketsId;
    data['surplus_number'] = this.surplusNumber;
    data['browse_id'] = this.browseId;
    data['is_top'] = this.isTop;
    data['top_end_time'] = this.topEndTime;
    data['views'] = this.views;
    data['top_update'] = this.topUpdate;
    data['deposit'] = this.deposit;
    data['act'] = this.act;
    data['reward_uri'] = this.rewardUri;
    data['reward_url'] = this.rewardUrl;
    data['cat_uri'] = this.catUri;
    data['cat_url'] = this.catUrl;
    data['phone'] = this.phone;
    data['nickname'] = this.nickname;
    data['cat_type'] = this.catType;
    return data;
  }
}