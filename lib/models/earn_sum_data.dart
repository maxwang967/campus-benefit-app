class EarnSumData {
  double mouthSum;
  double daySum;
  double yesterdaySum;
  double earnSum;

  EarnSumData({this.mouthSum, this.daySum, this.yesterdaySum, this.earnSum});

  EarnSumData.fromJson(Map<String, dynamic> json) {
    mouthSum = json['mouth_sum'];
    daySum = json['day_sum'];
    yesterdaySum = json['yesterday_sum'];
    earnSum = json['earn_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mouth_sum'] = this.mouthSum;
    data['day_sum'] = this.daySum;
    data['yesterday_sum'] = this.yesterdaySum;
    data['earn_sum'] = this.earnSum;
    return data;
  }
}
