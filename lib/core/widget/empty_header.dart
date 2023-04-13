import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/cash/storage.helper.dart';
import '../values/colors.dart';




class EmptyHeader extends StatefulWidget {
  EmptyHeader() ;

  @override
  State<EmptyHeader> createState() => _HeaderState();
}

class _HeaderState extends State<EmptyHeader> with StorageHelper {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width-70,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFF5F9F9),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
              color: const Color(0xFFF5F9F9)
            ),
            margin: const EdgeInsets.only(left: 10,right: 10),
            padding: const EdgeInsets.all(2),
            child: Row(
              children: <Widget>[
                const Icon(Icons.search),

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: tr("type_search"),
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(70, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: yellowColor
                  ),
                  onPressed: () async {


                  },
                  child: Text(
                    tr("Search"),
                    style: const TextStyle(
                        color: samaColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),


          InkWell(
              onTap: () => {

                  },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 46,
                    width: 46,
                    child: SvgPicture.asset(
                      'assets/images/shop.svg',
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    right: 2,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: samaColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2)),
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
        ],
      ),
    );
  }
}
