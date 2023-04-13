import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';


import '../../../../core/cash/storage.helper.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../../main.dart';
import '../../../auth/auth_model/empty_response.dart';
import 'model/OfferDetailsResponse.dart';
import 'model/offer_details_model.dart';
import 'offer_details.dart';

abstract class OfferDetailsViewModel extends State<OfferDetailsPage> with StorageHelper{
  OfferDetailsModel? offerDetailsModel;

  static String offerId="";

  bool isLoading=false;
  int index=0;

  @override
  void initState() {
    super.initState();

    getOfferDetailsApi();
  }




  Future<void> changeOfferApi(String status) async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> mp = {};
    mp["offer_id"] = offerId;
    mp["status"] = status;

    final response = await dio.post("v1/office/change-offer-status", data: mp);

    var rs = EmptyResponse(response.data!);
    setState(() {
      isLoading = false;
    });
    if (rs.status == 200) {
      getOfferDetailsApi();
      toastAppSuccess(rs.msg!, context);
    }else{
      toastApp(rs.msg!, context);
    }
  }


  Future<void> getOfferDetailsApi() async {
    Map<String, String> mp = {};

    mp["offer_id"] = offerId;


    final response = await dio.get("v1/offerDetails", queryParameters: mp);

    var rs = OffersDetailsResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        offerDetailsModel = rs.data;
       index= offerDetailsModel!.offerDetails!.status=="active" ? 0: 1 ;

      });
    }

  }




}