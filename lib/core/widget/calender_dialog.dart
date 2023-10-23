import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../values/colors.dart';

class CalenderDialog extends StatelessWidget {
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;
  CalenderDialog(this.onSelectionChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(

      backgroundColor: Colors.white,
surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: SizedBox(
        height: 520,
        child: Column(
          children: [
            SizedBox(
              height: 450,
              child: SfDateRangePicker(
                enablePastDates: false,
                showNavigationArrow: true,
                headerHeight: 55,
                showTodayButton: false,
                rangeTextStyle: const TextStyle(color: Colors.white),
                backgroundColor: Colors.white,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(color: yellowColor),
                    specialDatesTextStyle: TextStyle(color: Colors.black)),
                monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderHeight: 40,
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        backgroundColor: samaColor,
                        textStyle: GoogleFonts.tajawal(fontSize: 11,color: Colors.white))),
                view: DateRangePickerView.month,
                headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: samaColor,
                    textStyle: GoogleFonts.tajawal(color: Colors.white)),
                selectionMode: DateRangePickerSelectionMode.range,
                startRangeSelectionColor: samaColor,
                endRangeSelectionColor: samaColor,
                onSelectionChanged: onSelectionChanged,
                rangeSelectionColor: samaColor,
                todayHighlightColor: samaColor,
              ),
            ),
            SizedBox(
              width: 200,
              child: TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: Size(size.width - 30, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: yellowColor)),
                      backgroundColor: yellowColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    tr("Confirm"),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
