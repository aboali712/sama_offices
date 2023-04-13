import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../values/colors.dart';

class OrderVisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        height: 120,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/travel.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('OrderVisa'),
                style: GoogleFonts.tajawal(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                width: 130,
                height: 45,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(samaColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(
                          color: samaColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  child: Center(child: Text(tr('orderNow'),style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: yellowColor),)),
                  onPressed: ()  {

                  },
                ),
              ),


            ],
          ),
        ));
  }
}
