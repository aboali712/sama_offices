import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sama_offices/core/cash/storage.helper.dart';

import '../../src/home/home_core.dart';
import '../values/colors.dart';

class BottomMenu extends StatelessWidget
    with StorageHelper
    implements SelectBottomMenu {
  final int? bottomMenuIndex;
  final ValueChanged<int>? onChanged;
  BottomMenu({this.bottomMenuIndex, this.onChanged});
  static SelectBottomMenu? selectBottomMenu;

  BottomNavigationBarItem getItem(
    String image,
    String title,
    int index,
    ThemeData theme,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        image,
        height: 24.0,
        width: 24.0,
        color: bottomMenuIndex == 0 ? samaColor : grayColor,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    selectBottomMenu = this;

    List<BottomNavigationBarItem> items = [
      getItem('assets/images/home.svg', tr('Home'), 0, theme),
      getItem('assets/images/brands.svg', tr('Offers'), 1, theme),
      getItem('assets/images/brands.svg', tr('Brands'), 2, theme),
      getItem('assets/images/cart.svg', tr('Orders'), 3, theme),
      getItem('assets/images/profile.svg', tr('Profile'), 4, theme)
    ];

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: BottomNavigationBar(
          key: HomeCorePage.bottomWidgetKey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
          currentIndex: bottomMenuIndex!,
          onTap: (value) {
            switch (value) {
              case 0:
                onChanged!(0);
                break;

              case 1:
                onChanged!(1);
                break;
              case 2:
                onChanged!(2);
                break;
              case 3:
                onChanged!(3);
                break;
                // case 4:
                //   onChanged!(4);
                break;
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 46,
                    width: 46,
                    child: SvgPicture.asset(
                      'assets/images/home.svg',
                      height: 24.0,
                      width: 24.0,
                      color: bottomMenuIndex == 0 ? Colors.black : Colors.grey,
                    ),
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
                      child: Center(
                          child: Text(
                        HomeCore.count1,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )),
                    ),
                  )
                ],
              ),
              label: tr("ServiceRequests"),
            ),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 46,
                      width: 46,
                      child:
                      SvgPicture.asset(
                        'assets/images/discount.svg',
                        height: 24.0,
                        width: 24.0,
                        color: bottomMenuIndex == 1 ? Colors.black : Colors.grey,
                      ),
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
                        child: Center(
                            child: Text(
                          HomeCore.count2,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        )),
                      ),
                    )
                  ],
                ),
                label: tr(
                  "PackageRequests",
                )),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/more.svg',
                height: 24.0,
                width: 24.0,
                color: bottomMenuIndex == 2 ? Colors.black : Colors.grey,
              ),
              label: tr("Offers"),
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/heart.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 3 ? Colors.black : Colors.grey,
                ),
                label: tr('More')),
          ],
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: const IconThemeData(size: 25),
          selectedIconTheme: const IconThemeData(size: 25, color: samaColor),
        ),
      ),
    );
  }

  @override
  void selectBottomMenuItem(int pos) {
    onChanged!(pos);
  }
}

class SelectBottomMenu {
  void selectBottomMenuItem(int pos) {}
}
