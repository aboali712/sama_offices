import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../src/home/home_core.dart';
import '../values/colors.dart';



class BottomMenu extends StatelessWidget implements SelectBottomMenu {
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
                icon: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 0 ? yellowColor : Colors.white,
                ),
                label: tr("ServiceRequests"),),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/discount.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 1 ? yellowColor : Colors.white,
                ),
                label: tr("PackageRequests",)),

            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/more.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 3 ? yellowColor : Colors.white,
                ),
                label: tr('More')),
          ],
          selectedItemColor: yellowColor,
          backgroundColor: samaColor,
          unselectedItemColor: Colors.white,
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
