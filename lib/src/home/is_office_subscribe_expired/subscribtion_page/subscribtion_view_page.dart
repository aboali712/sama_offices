import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama_offices/src/auth/signup/all_filter/filter_model.dart';
import 'package:sama_offices/src/home/is_office_subscribe_expired/subscribtion_page/subscribtion_viewmodel.dart';

import '../../../../app.dart';
import '../../../../core/values/colors.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends SubscriptionViewModelPage {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.dark) /* set Status bar icon color in iOS. */
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [


            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

             SizedBox(
              height: Platform.isIOS? 50:40,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                InkWell(onTap: () {
                  Navigator.pop(context);
                },
                  child: Row(
                    children: [
                      InkWell(onTap: () {
                        Navigator.pop(context);

                      },child: const SizedBox(width: 10,
                          child: Icon(Icons.arrow_back_ios,size: 20,))),
                      const SizedBox(width: 10,),
                      SvgPicture.asset(
                        "assets/images/logo.svg",height: 20,width: 20,

                      ),

                    ],
                  ),
                ),

                Text(
                  tr("ReNew"),
                  style:   const TextStyle(
                      color:  Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),


                const SizedBox(width: 80,)

              ],
            ),


            const SizedBox(
              height: 50,
            ),
            Text(
              tr("SubscriptionPlan"),
              style:   const TextStyle(
                  color:  Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),


            const SizedBox(
              height: 20,
            ),
            filterModel != null?

            GridView.count(padding: EdgeInsets.zero,
                childAspectRatio: 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                physics:
                const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: filterModel != null
                    ? plansModel!.map((e) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        typeSelect=e.name!;
                        typeSelectId=e.id.toString();
                      });
                      print(typeSelectId);

                    },
                    child: Container(padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(color: typeSelect==e.name? samaOfficeColor: Colors.white,

                          border: Border.all(
                              width: .5,
                              color:
                              Colors.grey.shade500),
                          borderRadius:
                          BorderRadius
                              .circular(
                              15)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          const SizedBox(height: 10,),

                          Text(e.name!,style: GoogleFonts.tajawal(fontSize: 15,fontWeight: FontWeight.w500,
                              color: typeSelect==e.name?  Colors.white :samaOfficeColor
                          ),),
                          const SizedBox(height: 10,),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${tr("Price")} : ",style: GoogleFonts.tajawal(fontSize: 14,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),

                              Text(e.price!,style: GoogleFonts.tajawal(fontSize: 15,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),
                              Text(" ${tr("Sar")}",style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),

                            ],
                          ),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${tr("NumberOfMonths")} : ",style: GoogleFonts.tajawal(fontSize: 12,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),

                              Text(e.numOfMonths.toString(),style: GoogleFonts.tajawal(fontSize: 15,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),

                              Text(" ${tr("month")}",style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w500,
                                  color: typeSelect==e.name?  Colors.white :samaOfficeColor
                              ),),

                            ],
                          ),


                        ],
                      ),
                    ),
                  );
                }).toList()
                    : []
            )

                :  SizedBox(height: size.height/3,
                child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,))),










          ]),

            Positioned(bottom: 30,left: 20,right: 20,
              child: TextButton(
                style: TextButton.styleFrom(
                    fixedSize: const Size(260, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: samaOfficeColor),
                onPressed:() async {
                  if(await check()){
                    pay();
                  }


                },
                child: Text(
                  tr("renewal"),
                  style:   const TextStyle(
                      color:  Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
            ),


            isLoading==true?
                SizedBox(height: size.height/1,
                    child: const Center(child: CircularProgressIndicator(color: samaOfficeColor,)))
                :const SizedBox.shrink()



        ]),
      ),

    );
  }
}
