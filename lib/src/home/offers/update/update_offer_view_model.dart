import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama_offices/app.dart';
import 'package:sama_offices/core/utils/helper_manager.dart';
import 'package:sama_offices/src/auth/auth_model/empty_response.dart';
import 'package:sama_offices/src/home/offers/update/update_offer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/widget/calender_dialog.dart';
import '../../../../main.dart';
import '../../../auth/signup/all_filter/cities_model.dart';
import '../../../auth/signup/all_filter/city_response.dart';
import '../../../auth/signup/all_filter/filter_model.dart';
import '../../../auth/signup/all_filter/filter_response.dart';
import '../all/models/offer_model.dart';

abstract class UpdateOfferPageViewModel extends State<UpdateOfferPage>
    with SingleTickerProviderStateMixin {
  static OfferModel? offerModel;

  TabController? tabControllerTitle;

  TextEditingController titleArController = TextEditingController();
  TextEditingController titleEnController = TextEditingController();
  HtmlEditorController controllerDetailsAr = HtmlEditorController();

  TextEditingController priceAfterController = TextEditingController();
  TextEditingController priceBeforeController = TextEditingController();

  HtmlEditorController controllerDetailsEn = HtmlEditorController();

  String? selectedOfficeBranch;
  String? selectedCityBranch;
  String? selectedOfficeBranchID;
  String selectedCityBranchID = "";
  String startSelectedDate = '';
  String endSelectedDate = '';

  String countryId = "";
  List<CityModel> cites = [];
  FilterModel? filterModel;
  List listStatues = [tr("Normal"), tr("Weekend")];
  String selectStatus = tr("Normal");
  bool isLoading = false;

  var index = 0;
  ImagePicker picker = ImagePicker();

  XFile? imageOffice;
  List<XFile>? images;
  var detailsAr = "";
  var detailsEn = "";

  @override
  void initState() {
    tabControllerTitle = TabController(length: 2, vsync: this);
    tabControllerTitle!.index = 0;


    getFilterDataApi();
    super.initState();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      startSelectedDate =
          DateFormat('yyyy-MM-dd', "en").format(args.value.startDate);

      endSelectedDate = DateFormat('yyyy-MM-dd', "en")
          .format(args.value.endDate ?? args.value.startDate);
    });
  }

  void selectDate() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CalenderDialog(onSelectionChanged);
        });
  }

  Future<void> getFilterDataApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> mp = {};

    final response = await dio.get("v1/filter", queryParameters: mp);
    setState(() {
      isLoading = false;
    });
    var rs = FilterResponse(response.data!);
    if (rs.status == 200) {
      setState(() {
        filterModel = rs.data;
        setData();
      });
    }
  }

  void setData() {
    setState(() {
      isLoading = true;
    });

    setState(() async {
      titleArController.text=offerModel!.nameAr!;
      titleEnController.text=offerModel!.nameEn!;
      detailsAr=offerModel!.descriptionAr!;
      detailsEn=offerModel!.descriptionEn!;
      selectStatus ==  "normal" ? tr("Normal")  : tr("Weekend");
      priceBeforeController.text=offerModel!.priceBefore!.toString();

      priceAfterController.text=offerModel!.priceAfter!.toString();

      selectedOfficeBranch = filterModel!.countries!
          .firstWhere((element) => element.id == offerModel!.countryId)
          .name;
      countryId = offerModel!.countryId.toString();
      selectedCityBranchID=offerModel!.cityId.toString();
      Map<String, String> mp = {};
      mp["country_id"] = countryId;

      final response = await dio.get("v1/cities", queryParameters: mp);
      setState(() {
        isLoading = false;
      });
      var rs = CitiesResponse(response.data!);
      if (rs.status == 200) {
        setState(() {
          cites = rs.data!;
          selectedCityBranch=cites .firstWhere((element) => element.id == offerModel!.cityId)
              .name;
        });
      }



      startSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.startDate!));

      endSelectedDate = DateFormat('yyyy-MM-dd', "en").format(DateFormat('yyyy-MM-dd', "en").parse(offerModel!.endDate!));
    });
  }

  Future<void> getCityDataApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> mp = {};
    mp["country_id"] = countryId;

    final response = await dio.get("v1/cities", queryParameters: mp);

    var rs = CitiesResponse(response.data!);
    setState(() {
      isLoading = false;
    });
    if (rs.status == 200) {
      setState(() {
        cites = rs.data!;
      });
    }
  }


  Future<void> addOfferApiCall() async {
    if (await checkData()) {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> mp = {};

       if(images!=null) {

        images?.asMap().forEach((index, element) async {
          print("images[$index]");
          mp["images[$index]"] = await MultipartFile.fromFile(element.path,
              filename: element.path
                  .split('/')
                  .last);
        });
      }

      mp["type"] = selectStatus == tr("Normal") ? "normal" : "weekend";
      mp["name_ar"] = titleArController.value.text.toString();
      mp["name_en"] = titleEnController.value.text.toString();
      mp["description_ar"] = detailsAr;
      mp["description_en"] = detailsEn;
      mp["country_id"] = countryId;
      mp["city_id"] = selectedCityBranchID;
      mp["price_after"] = priceAfterController.value.text.toString();
      mp["is_vip"]="0";

      mp["price_before"] = priceBeforeController.value.text.toString();

      mp["start_date"] = startSelectedDate;
      mp["end_date"] = endSelectedDate;




      if(imageOffice!=null) {
        mp["image"] = await MultipartFile.fromFile(imageOffice!.path,
            filename: imageOffice!
                .path
                .split('/')
                .last);
      }
     await Future.delayed(const Duration(seconds: 1));

      final response =
          await dio.post("v1/office/offers/${offerModel!.id}/update", data: FormData.fromMap(mp));

      var rs = EmptyResponse(response.data!);
      setState(() {
        isLoading = false;
      });

      if (rs.status == 200) {
        setState(() {
          toastAppSuccess(rs.msg!, context);
          SamaOfficesApp.navKey.currentState!.pop(context);
        });
      } else {
        toastApp(rs.msg!, context);
      }
    }
  }

  getImages(Map mp){

  }

  Future<bool> checkData() async {
    if (titleArController.value.text.isEmpty) {
      toastApp(tr("titleAr"), context);
      return false;
    } else if (titleEnController.value.text.isEmpty) {
      toastApp(tr("titleEn"), context);
      return false;
    } else if (detailsAr.isEmpty) {
      toastApp(tr("DescriptionAr"), context);
      return false;
    } else if (detailsEn.isEmpty) {
      toastApp(tr("DescriptionEn"), context);
      return false;
    } else if (countryId == "") {
      toastApp(tr("ChooseCountry"), context);
      return false;
    } else if (selectedCityBranchID == "") {
      toastApp(tr("ChooseTheCity"), context);
      return false;
    }
    if (priceAfterController.value.text.isEmpty) {
      toastApp(tr("PriceBefore"), context);
      return false;
    }
    if (priceBeforeController.value.text.isEmpty) {
      toastApp(tr("PriceAfter"), context);
      return false;
    }

    if (startSelectedDate == '') {
      toastApp(tr("ChooseDate"), context);
      return false;
    }


    return true;
  }
}
