import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sama_offices/src/home/is_office_subscribe_expired/subscribtion_page/subscribtion_view_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/utils/helper_manager.dart';
import '../../../auth/signup/all_filter/filter_model.dart';
import '../../../auth/signup/all_filter/filter_response.dart';
import '../../payment/model/payment_response.dart';
import '../../payment/payment_view.dart';

abstract class SubscriptionViewModelPage extends State<SubscriptionPage>{
  final Dio dio = NetworkService.instance.dio;

  FilterModel? filterModel;
  String? selectedSubscriptionPlan;

  String typeSelect="";
  String typeSelectId="";
  bool isLoading=false;

  @override
  void initState() {
    getFilterDataApi();
    super.initState();
  }



  Future<void> getFilterDataApi() async {
    Map<String, String> mp = {};

    final response = await dio.get("v1/filter", queryParameters: mp);

    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;

      });
    }

  }


  Future<void> pay() async {
    setState(() {
      isLoading=true;
    });

    Map<String, String> mp = {};
    mp["type"]="subscribe_office";
    mp["plan_id"]=typeSelectId.toString();

    var payment= await dio.post("v1/getCheckoutUrl",data: mp);
    var response=PaymentResponse(payment.data);
    setState(() {
      isLoading=false;
    });

    if(response.status==200){
      WebViewOfferPaymentState.openUrl=response.data!.url.toString();
      SamaOfficesApp.navKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const WebViewOfferPayment()),
      );

    }else{
      toastAppSuccess(response.msg.toString(),context);
    }

  }




}