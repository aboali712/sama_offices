class Transits {
  String? startCity;
  String? startDate;
  String? endCity;
  String? endDate;

  Transits({this.startCity, this.startDate, this.endCity, this.endDate});

  Transits.fromJson(Map<String, dynamic> json) {
    startCity = json['start_city'];
    startDate = json['start_date'];
    endCity = json['end_city'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_city'] = startCity;
    data['start_date'] = startDate;
    data['end_city'] = endCity;
    data['end_date'] = endDate;
    return data;
  }
}