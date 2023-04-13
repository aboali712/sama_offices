class PlansModel {
  int? id;
  String? name;
  String? description;
  int? numOfMonths;
  String? price;
  dynamic status;

  PlansModel(
      {this.id,
        this.name,
        this.description,
        this.numOfMonths,
        this.price,
        this.status});

  PlansModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    numOfMonths = json['num_of_months'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['num_of_months'] = this.numOfMonths;
    data['price'] = this.price;
    data['status'] = this.status;
    return data;
  }
}