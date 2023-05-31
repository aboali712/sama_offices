import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app.dart';
import '../../../core/values/colors.dart';
import '../notifcation_page.dart';
import 'HomeViewModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: samaColor,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.light,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
        Brightness.light) /* set Status bar icon color in iOS. */
    );
    return Scaffold(
      body: Column(
        children: [

          Container(
            height: 100,
            padding: const EdgeInsets.only(top: 60),
            width: MediaQuery.of(context).size.width,
            alignment: AlignmentDirectional.topCenter,
            color: yellowColor,
            child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 49,),



                  Text(tr("Home"),style: GoogleFonts.tajawal(fontSize: 16,fontWeight: FontWeight.bold,
                      color:Colors.black ),),

                  InkWell(
                      onTap: () => {
                        SamaOfficesApp.navKey.currentState!.push(
                          MaterialPageRoute(
                              builder: (context) =>
                              const NotificationPage()),
                        )
                      },
                      child: Stack(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              height: 46,
                              width: 46,
                              child:const Icon(Icons.notifications_none,color: Colors.white,)
                          ),
                          Positioned(
                            right: 2,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.red, width: 2)),
                              child: const Center(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  )

                              ),
                            ),
                          )
                        ],
                      )),

                ]),
          ),





          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    children: [




                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(height: 100,width: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black,width: .3)
                          ),

                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.local_offer_outlined,color: profile,),
                                  Text("0",style: GoogleFonts.tajawal(fontSize: 14,fontWeight: FontWeight.w500,
                                  ) ),
                                  Text(tr("Offers"),style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w500,
                                  ) ),


                                ]),
                          ),



                          Container(height: 100,width: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black,width: .3)
                          ),

                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/discount.svg',height: 25,width: 25,color: profile,),
                                  Text("0",style: GoogleFonts.tajawal(fontSize: 14,fontWeight: FontWeight.w500,
                                  ) ),
                                  Text(tr("PackageRequests"),style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w500,
                                  ) ),


                                ]),
                          ),



                          Container(height: 100,width: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black,width: .3)
                          ),

                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset("assets/images/moneypage.png",height: 25,width: 25,color: samaColor,),
                                  Text("0",style: GoogleFonts.tajawal(fontSize: 14,fontWeight: FontWeight.w500,
                                  ) ),
                                  Text("المبيعات",style: GoogleFonts.tajawal(fontSize: 13,fontWeight: FontWeight.w500,
                                  ) ),


                                ]),
                          ),



                        ],),
                      const SizedBox(height: 20,),


                      Card(elevation: 2,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        child: Container(width: size.width,
                          padding: const EdgeInsets.all(20),
                          decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("أخر الحجوزات",style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 15),),
                                const SizedBox(height: 20,),

                                Center(child: Text("لا يوجد لديك حجوزات جديدة",style:
                                GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),)),

                                SizedBox(
                                    child: Divider(
                                      thickness: .5,
                                      color: Colors.grey.shade400,
                                    )),

                                const SizedBox(height: 10,),


                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("المزيد",style:
                                    GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),),


                                    const Icon(Icons.chevron_right,color: Colors.grey,)



                                  ],)





                              ]),
                        ),
                      ),


                      const SizedBox(height: 20,),


                      Card(elevation: 2,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        child: Container(width: size.width,
                          padding: const EdgeInsets.all(20),
                          decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/heart.png",height: 20,width: 20,color: samaColor,
                                    ),
                                    const SizedBox(width: 5,),
                                    Text("الضيوف القادمين",style: GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 15),),
                                  ],
                                ),
                                const SizedBox(height: 20,),

                                Center(child: Text("لا يوجد لديك ضيوف قادمين",style:
                                GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),)),

                                SizedBox(
                                    child: Divider(
                                      thickness: .5,
                                      color: Colors.grey.shade400,
                                    )),

                                const SizedBox(height: 10,),


                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("المزيد",style:
                                    GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),),


                                    const Icon(Icons.chevron_right,color: Colors.grey,)



                                  ],)





                              ]),
                        ),
                      ),



                      const SizedBox(height: 20,),


                      Card(elevation: 2,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                        child: Container(width: size.width,
                          padding: const EdgeInsets.all(20),
                          decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),

                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("أخر التقييمات",style:
                                    GoogleFonts.tajawal(fontWeight: FontWeight.bold,fontSize: 15),),


                                    Text("متوسط أجمالى التقييمات",style:
                                    GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 12,
                                        color: Colors.grey
                                    ),),


                                  ],
                                ),
                                const SizedBox(height: 10,),



                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(padding: const EdgeInsets.only(top: 10,bottom: 5),
                                          height: 65,width: 68,child:
                                          Column(children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("0",style:
                                                GoogleFonts.tajawal(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                                                Text("/10",style: GoogleFonts.tajawal(fontSize: 13),)

                                              ],),
                                            const SizedBox(height: 5,),

                                            Text("النظافة",style: GoogleFonts.tajawal(fontSize: 12,fontWeight:FontWeight.w500 ),)



                                          ]),)),

                                    Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(padding:  const EdgeInsets.only(top: 10,bottom: 5),
                                          height: 65,width: 68,child:
                                          Column(children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("0",style:
                                                GoogleFonts.tajawal(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                                                Text("/10",style: GoogleFonts.tajawal(fontSize: 13),)

                                              ],),
                                            const SizedBox(height: 5,),

                                            Text("الحالة",style: GoogleFonts.tajawal(fontSize: 12,fontWeight:FontWeight.w500 ),)



                                          ]),)),

                                    Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(padding: const EdgeInsets.only(top: 10,bottom: 5),
                                          height: 65,width: 68,child:
                                          Column(children: [
                                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("0",style:
                                                GoogleFonts.tajawal(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                                                Text("/10",style: GoogleFonts.tajawal(fontSize: 13),)

                                              ],),
                                            const SizedBox(height: 5,),

                                            Text("الخدمة",style: GoogleFonts.tajawal(fontSize: 12,fontWeight:FontWeight.w500 ),)



                                          ]),)),

                                    Card(elevation: 2,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Container(padding: const EdgeInsets.only(top: 10,bottom: 5),
                                          height: 65,width: 68,child:
                                          Column(
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("0",style:
                                                    GoogleFonts.tajawal(color: Colors.green,fontSize: 18,fontWeight: FontWeight.bold),),
                                                    Text("/10",style: GoogleFonts.tajawal(fontSize: 13),)

                                                  ],),
                                                const SizedBox(height: 5,),

                                                Text("المعلومات",style:
                                                GoogleFonts.tajawal(fontSize: 10,fontWeight:FontWeight.w500 ),)



                                              ]),))




                                  ],),



                                const SizedBox(height: 20,),

                                Center(child: Text("لا يوجد لديك تقييمات",style:
                                GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),)),

                                SizedBox(
                                    child: Divider(
                                      thickness: .5,
                                      color: Colors.grey.shade400,
                                    )),

                                const SizedBox(height: 10,),


                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("المزيد",style:
                                    GoogleFonts.tajawal(fontWeight: FontWeight.w400,fontSize: 14),),


                                    const Icon(Icons.chevron_right,color: Colors.grey,)



                                  ],)








                              ]),
                        ),
                      ),









                    ]),
              ),
            ),
          ),
        ],
      ),



    );
  }
}