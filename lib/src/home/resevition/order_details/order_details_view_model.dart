import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:sama_offices/core/cash/storage.helper.dart';
import 'package:sama_offices/core/utils/helper_manager.dart';
import 'package:sama_offices/src/auth/auth_model/empty_response.dart';
import 'package:sama_offices/src/home/resevition/model/get_bookings_model.dart';

import '../../../../main.dart';
import 'order_details_view.dart';

abstract class OrderDetailsViewModel extends State<OrderDetails> with StorageHelper{

   BookingsModel bookingsModelDetails=BookingsModel();
  static BookingsModel bookingsModel=BookingsModel();
   int select=1;
   List listStatues= [tr("Pending"),tr("Accepted"),tr("Reviewing"),tr("Processing"),tr("Completed"),tr("Cancelled") ];
   String selectStatus="";
   bool isLoading=false;


  @override
  void initState() {
   setState(() {
     bookingsModelDetails=bookingsModel;
     selectStatus= bookingsModelDetails.status=="pending" ? tr("Pending") :  bookingsModelDetails.status=="accepted" ? tr("Accepted")
         :  bookingsModelDetails.status=="inReview" ? tr("Reviewing") :  bookingsModelDetails.status=="processing" ? tr("Processing")
         :  bookingsModelDetails.status=="completed" ? tr("Completed") :  tr("Cancelled");
   });
    super.initState();
  }


   Future<void> changeStatusReservationsApi() async {
     Map<String, String> mp = {};
     setState(() {
       isLoading=true;
     });
     mp["reservation_id"]=bookingsModelDetails.id.toString();
     var st = selectStatus==tr("Pending") ? "pending"   : selectStatus== tr("Accepted")? "accepted"
         :  selectStatus== tr("Reviewing") ? "inReview"  : selectStatus== tr("Processing")?"processing"
         :  selectStatus== tr("Completed")?"completed"  :  "canceled";
     mp["status"] = st;
     final response =
     await dio.post("v1/office/changeStatus", data: mp);
     setState(() {
       isLoading=false;
     });
     var rs = EmptyResponse(response.data!);
     if (rs.status == 200) {
       toastAppSuccess(rs.msg!, context);
       setState(() {
         bookingsModelDetails.status=st;
       });
     }else{
       toastApp(rs.msg!, context);

     }
   }

}