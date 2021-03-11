class RG1OrderDataList {
  List<RG1OrderData> data;

  RG1OrderDataList({this.data});

  RG1OrderDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RG1OrderData>();
      json['data'].forEach((v) {
        data.add(new RG1OrderData.fromJson(v));
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

class RG1OrderData {
  int id;
  String platform;
  String school;
  String account;
  String password;
  String date;
  int user;

  RG1OrderData(
      {this.id,
      this.platform,
      this.school,
      this.account,
      this.password,
      this.date,
      this.user});

  RG1OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    platform = json['platform'];
    school = json['school'];
    account = json['account'];
    password = json['password'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['platform'] = this.platform;
    data['school'] = this.school;
    data['account'] = this.account;
    data['password'] = this.password;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}

class RG1OrderCourseDataList {
	int total;
	List<RG1OrderCourseData> rows;
	int code;
	String all;
	String unitTotal;
	String courseTotal;
	String unitAll;

	RG1OrderCourseDataList({this.total, this.rows, this.code, this.all, this.unitTotal, this.courseTotal, this.unitAll});

	RG1OrderCourseDataList.fromJson(Map<String, dynamic> json) {
		total = json['total'];
		if (json['rows'] != null) {
			rows = new List<RG1OrderCourseData>();
			json['rows'].forEach((v) { rows.add(new RG1OrderCourseData.fromJson(v)); });
		}
		code = json['code'];
		all = json['all'];
		unitTotal = json['unitTotal'];
		courseTotal = json['courseTotal'];
		unitAll = json['unitAll'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = this.total;
		if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
		data['code'] = this.code;
		data['all'] = this.all;
		data['unitTotal'] = this.unitTotal;
		data['courseTotal'] = this.courseTotal;
		data['unitAll'] = this.unitAll;
		return data;
	}
}

class RG1OrderCourseData {
	String searchValue;
	String createBy;
	String createTime;
	String updateBy;
	String updateTime;
	String remark;
	int id;
	String no;
	String username;
	String password;
	int platformId;
	String platformName;
	String schoolName;
	String courseName;
	String courseType;
	String courseId;
	int unitTotal;
	String unitCount;
	String unitComplete;
	String unitIncomplete;
	String unitClockTime;
	String unitRunTime;
	double totalPrice;
	String unitPirce;
	String status;
	String createDate;
	String createUser;
	String updateDate;
	String updateUser;
	int retry;
	String callTime;
	String backTime;
	String runTime;
	String extend;
	int userId;
	String orderType;
	String jobStatus;
	int jobCount;
	String jobTime;
	String createDateDesc;
	String job;
	String run;
	int hour;
	String buyPrice;
	String failure;
	String major;
	int isDel;
	String isApi;

	RG1OrderCourseData({this.searchValue, this.createBy, this.createTime, this.updateBy, this.updateTime, this.remark, this.id, this.no, this.username, this.password, this.platformId, this.platformName, this.schoolName, this.courseName, this.courseType, this.courseId, this.unitTotal, this.unitCount, this.unitComplete, this.unitIncomplete, this.unitClockTime, this.unitRunTime, this.totalPrice, this.unitPirce, this.status, this.createDate, this.createUser, this.updateDate, this.updateUser, this.retry, this.callTime, this.backTime, this.runTime, this.extend, this.userId, this.orderType, this.jobStatus, this.jobCount, this.jobTime, this.createDateDesc, this.job, this.run, this.hour, this.buyPrice, this.failure, this.major, this.isDel, this.isApi});

	RG1OrderCourseData.fromJson(Map<String, dynamic> json) {
		searchValue = json['searchValue'];
		createBy = json['createBy'];
		createTime = json['createTime'];
		updateBy = json['updateBy'];
		updateTime = json['updateTime'];
		remark = json['remark'];
		id = json['id'];
		no = json['no'];
		username = json['username'];
		password = json['password'];
		platformId = json['platformId'];
		platformName = json['platformName'];
		schoolName = json['schoolName'];
		courseName = json['courseName'];
		courseType = json['courseType'];
		courseId = json['courseId'];
		unitTotal = json['unitTotal'];
		unitCount = json['unitCount'];
		unitComplete = json['unitComplete'];
		unitIncomplete = json['unitIncomplete'];
		unitClockTime = json['unitClockTime'];
		unitRunTime = json['unitRunTime'];
		totalPrice = json['totalPrice'];
		unitPirce = json['unitPirce'];
		status = json['status'];
		createDate = json['createDate'];
		createUser = json['createUser'];
		updateDate = json['updateDate'];
		updateUser = json['updateUser'];
		retry = json['retry'];
		callTime = json['callTime'];
		backTime = json['backTime'];
		runTime = json['runTime'];
		extend = json['extend'];
		userId = json['userId'];
		orderType = json['orderType'];
		jobStatus = json['jobStatus'];
		jobCount = json['jobCount'];
		jobTime = json['jobTime'];
		createDateDesc = json['createDateDesc'];
		job = json['job'];
		run = json['run'];
		hour = json['hour'];
		buyPrice = json['buyPrice'];
		failure = json['failure'];
		major = json['major'];
		isDel = json['isDel'];
		isApi = json['isApi'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['searchValue'] = this.searchValue;
		data['createBy'] = this.createBy;
		data['createTime'] = this.createTime;
		data['updateBy'] = this.updateBy;
		data['updateTime'] = this.updateTime;
		data['remark'] = this.remark;
		data['id'] = this.id;
		data['no'] = this.no;
		data['username'] = this.username;
		data['password'] = this.password;
		data['platformId'] = this.platformId;
		data['platformName'] = this.platformName;
		data['schoolName'] = this.schoolName;
		data['courseName'] = this.courseName;
		data['courseType'] = this.courseType;
		data['courseId'] = this.courseId;
		data['unitTotal'] = this.unitTotal;
		data['unitCount'] = this.unitCount;
		data['unitComplete'] = this.unitComplete;
		data['unitIncomplete'] = this.unitIncomplete;
		data['unitClockTime'] = this.unitClockTime;
		data['unitRunTime'] = this.unitRunTime;
		data['totalPrice'] = this.totalPrice;
		data['unitPirce'] = this.unitPirce;
		data['status'] = this.status;
		data['createDate'] = this.createDate;
		data['createUser'] = this.createUser;
		data['updateDate'] = this.updateDate;
		data['updateUser'] = this.updateUser;
		data['retry'] = this.retry;
		data['callTime'] = this.callTime;
		data['backTime'] = this.backTime;
		data['runTime'] = this.runTime;
		data['extend'] = this.extend;
		data['userId'] = this.userId;
		data['orderType'] = this.orderType;
		data['jobStatus'] = this.jobStatus;
		data['jobCount'] = this.jobCount;
		data['jobTime'] = this.jobTime;
		data['createDateDesc'] = this.createDateDesc;
		data['job'] = this.job;
		data['run'] = this.run;
		data['hour'] = this.hour;
		data['buyPrice'] = this.buyPrice;
		data['failure'] = this.failure;
		data['major'] = this.major;
		data['isDel'] = this.isDel;
		data['isApi'] = this.isApi;
		return data;
	}
}

