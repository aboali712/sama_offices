
import 'imageModel.dart';

class OfferModel {
  int? id;
  String? type;
  int? officeId;
  String? officeName;
  String? officeImage;
  String? name;
  String? nameAr;
  String? nameEn;
  String? status;
  dynamic is_vip;


  String? image;
  bool? is_favourite;
  String? description;
  String? descriptionAr;
  String? descriptionEn;
  int? countryId;
  List<String>? countries_list;
  List<String>? cities_list;
  int? cityId;

  String? fromCity;
  String? toCity;
  String? priceBefore;
  String? priceAfter;
  String? startDate;
  String? endDate;
  int? numOfDays;
  List<ImagesModel>? images;
  String? offer_type;
  int? num_of_persons;
  int? num_of_nights;
  int? num_of_reserved_persons;


  OfferModel(
      {this.id,
        this.type,
        this.officeId,
        this.officeName,
        this.officeImage,
        this.is_favourite,
        this.status,
        this.is_vip,
        this.name,
        this.image,
        this.cityId,
        this.descriptionAr,
        this.descriptionEn,
        this.nameAr,
        this.nameEn,
        this.description,
        this.countryId,
         this.cities_list, this.countries_list,
        this.fromCity,
        this.toCity,
        this.priceBefore,
        this.priceAfter,
        this.startDate,
        this.endDate,
        this.numOfDays,this.offer_type,this.num_of_persons,this.num_of_nights,this.num_of_reserved_persons});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    officeId = json['office_id'];
    is_favourite = json['is_favourite'];

    officeName = json['office_name'];
    officeImage = json['office_image'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    status = json['status'];
    is_vip = json['is_vip'];

    image = json['image'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];

    countryId = json['country_id'];
    cityId = json['city_id'];

    cities_list = json['cities_list'].cast<String>();
    countries_list = json['countries_list'].cast<String>();
    fromCity = json['from_city'];
    toCity = json['to_city'];
    priceBefore = json['price_before'];
    priceAfter = json['price_after'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    numOfDays = json['num_of_days'];
    if (json['images'] != null) {
      images = <ImagesModel>[];
      json['images'].forEach((v) {
        images!.add(ImagesModel.fromJson(v));
      });
    }
    offer_type = json['offer_type'];
    num_of_persons = json['num_of_persons'];
    num_of_nights = json['num_of_nights'];
    num_of_reserved_persons = json['num_of_reserved_persons'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['office_id'] = this.officeId;
    data['office_name'] = this.officeName;
    data['office_image'] = this.officeImage;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['status'] = this.status;
    data['is_vip'] = this.is_vip;

    data['image'] = this.image;
    data['description'] = this.description;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;

    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;

    data['countries_list'] = this.countries_list;
    data['cities_list'] = this.cities_list;
    data['from_city'] = this.fromCity;
    data['to_city'] = this.toCity;
    data['is_favourite'] = this.is_favourite;

    data['price_before'] = this.priceBefore;
    data['price_after'] = this.priceAfter;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['num_of_days'] = this.numOfDays;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['offer_type'] = this.offer_type;
    data['num_of_persons'] = this.num_of_persons;
    data['num_of_nights'] = this.num_of_nights;
    data['num_of_reserved_persons'] = this.num_of_reserved_persons;



    return data;
  }
}