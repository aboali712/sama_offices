
import 'package:sama_offices/src/home/resevition/model/transits.dart';

class MyServiceModel {
  int? id;
  int? reservationId;
  int? serviceId;
  int? nationalityId;
  String? nationalityTitle;
  int? countryId;
  String? countryTitle;
  String? startPlace;
  String? endPlace;
  String? startDate;
  String? endDate;
  String? address;
  String? rooms;
  String? guests;
  List<Transits>? transits;
  String? notes;
  List<String>? attachments;
  String? ticketType;
  String? passengers;
  String? ticketClass;
  int? withoutStop;
  String? licenseType;

  MyServiceModel(
      {this.id,
        this.reservationId,
        this.serviceId,
        this.nationalityId,
        this.nationalityTitle,
        this.countryId,
        this.countryTitle,
        this.startPlace,
        this.endPlace,
        this.startDate,
        this.endDate,
        this.address,
        this.rooms,
        this.guests,
        this.transits,
        this.notes,
        this.attachments,
        this.ticketType,
        this.passengers,
        this.ticketClass,
        this.withoutStop,
        this.licenseType});

  MyServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reservationId = json['reservation_id'];
    serviceId = json['service_id'];
    nationalityId = json['nationality_id'];
    nationalityTitle = json['nationality_title'];
    countryId = json['country_id'];
    countryTitle = json['country_title'];
    startPlace = json['start_place'];
    endPlace = json['end_place'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    rooms = json['rooms'];
    guests = json['guests'];
    if (json['transits'] != null) {
      transits = <Transits>[];
      json['transits'].forEach((v) {
        transits!.add(new Transits.fromJson(v));
      });
    }
    notes = json['notes'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
        attachments!.add(v);
      });
    }
    ticketType = json['ticket_type'];
    passengers = json['passengers'];
    ticketClass = json['ticket_class'];
    withoutStop = json['without_stop'];
    licenseType = json['license_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reservation_id'] = this.reservationId;
    data['service_id'] = this.serviceId;
    data['nationality_id'] = this.nationalityId;
    data['nationality_title'] = this.nationalityTitle;
    data['country_id'] = this.countryId;
    data['country_title'] = this.countryTitle;
    data['start_place'] = this.startPlace;
    data['end_place'] = this.endPlace;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['address'] = this.address;
    data['rooms'] = this.rooms;
    data['guests'] = this.guests;
    if (this.transits != null) {
      data['transits'] = this.transits!.map((v) => v.toJson()).toList();
    }
    data['notes'] = this.notes;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v).toList();
    }
    data['ticket_type'] = this.ticketType;
    data['passengers'] = this.passengers;
    data['ticket_class'] = this.ticketClass;
    data['without_stop'] = this.withoutStop;
    data['license_type'] = this.licenseType;
    return data;
  }
}