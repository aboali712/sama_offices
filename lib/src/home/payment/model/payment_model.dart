class PaymentModel {
  String? timezone;
  String? created;
  String? url;
  Expiry? expiry;
  bool? asynchronous;
  int? amount;
  String? currency;

  PaymentModel(
      {this.timezone,
        this.created,
        this.url,
        this.expiry,
        this.asynchronous,
        this.amount,
        this.currency});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    created = json['created'];
    url = json['url'];
    expiry =
    json['expiry'] != null ? new Expiry.fromJson(json['expiry']) : null;
    asynchronous = json['asynchronous'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['created'] = this.created;
    data['url'] = this.url;
    if (this.expiry != null) {
      data['expiry'] = this.expiry!.toJson();
    }
    data['asynchronous'] = this.asynchronous;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class Expiry {
  int? period;
  String? type;

  Expiry({this.period, this.type});

  Expiry.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['type'] = this.type;
    return data;
  }
}