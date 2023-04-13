import 'package:flutter/cupertino.dart';
import 'package:sama_offices/src/home/offers/all/models/offer_model.dart';

import '../../../../main.dart';
import 'models/OffersResponse.dart';
import 'models/offers_page_model.dart';
import 'offers_page.dart';

abstract class OffersPageViewModel extends State<OffersPage> {
  List<OfferModel>? offerPageModel;
  bool isLoading = false;



  @override
  void initState() {
    super.initState();
    getOffersDataApi();
  }

  Future<void> getOffersDataApi() async {
    setState(() {
      isLoading=true;
    });
    final response = await dio.get("v1/office/offers");

    var rs = OffersResponse(response.data!);
    setState(() {
      isLoading=false;
    });
    if (rs.status == 200) {
      setState(() {
        offerPageModel = rs.data;
      });
    }
  }
}
