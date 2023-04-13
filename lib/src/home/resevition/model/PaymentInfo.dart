class PaymentInfo {
  String? bankName;
  String? bankAccount;
  String? iban;

  PaymentInfo({this.bankName, this.bankAccount, this.iban});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccount = json['bank_account'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['bank_account'] = this.bankAccount;
    data['iban'] = this.iban;
    return data;
  }
}