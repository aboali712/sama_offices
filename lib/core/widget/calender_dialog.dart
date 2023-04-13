import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderDialog extends StatelessWidget {
  CalenderDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: SizedBox(
        height: 450,
        child: SfDateRangePicker(
          enablePastDates: false,
          selectionMode: DateRangePickerSelectionMode.range,
          startRangeSelectionColor: Colors.blue,
          endRangeSelectionColor: Colors.blue,
          rangeSelectionColor: Colors.blue.withOpacity(.5),
          todayHighlightColor: Colors.blue,


        ),
      ),
    );
  }
}
