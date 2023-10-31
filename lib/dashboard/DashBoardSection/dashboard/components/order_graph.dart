import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';

class OrderGraph extends StatefulWidget {
  const OrderGraph({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderGraph> createState() => _OrderGraphState();
}

class _OrderGraphState extends State<OrderGraph> {
  // late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true,
    tooltipPosition: TooltipPosition.auto,
    );
    _getlastWeek();
    _getSevenDaysData();
    super.initState();
  }

  String _day(String _timestamp) {
    String formattedDate = DateFormat('EE').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _date(String _timestamp) {
    String formattedDate =
        DateFormat('dd MMM, yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  var lastDate;
  var firstday;
  var secondday;
  var thirdday;
  var fourthday;
  var fifthday;
  var sixthday;
  var seventhday;
  var firstdayname;
  var seconddayname;
  var thirddayname;
  var fourthdayname;
  var fifthdayname;
  var sixthdayname;
  var seventhdayname;

  _getdaysName() {
    setState(() {
      firstdayname = _day(firstday.toString());
      seconddayname = _day(secondday.toString());
      thirddayname = _day(thirdday.toString());
      fourthdayname = _day(fourthday.toString());
      fifthdayname = _day(fifthday.toString());
      sixthdayname = _day(sixthday.toString());
      seventhdayname = _day(seventhday.toString());
    });
  }

  _getlastWeek() {
    setState(() {
      firstday = DateTime.now();
      secondday = DateTime.now().subtract(Duration(days: 1));
      thirdday = DateTime.now().subtract(Duration(days: 2));
      fourthday = DateTime.now().subtract(Duration(days: 3));
      fifthday = DateTime.now().subtract(Duration(days: 4));
      sixthday = DateTime.now().subtract(Duration(days: 5));
      seventhday = DateTime.now().subtract(Duration(days: 6));
    });
    print(_day(seventhday.toString()));
    _getdaysName();
    // lastDate: DateTime(2100),
  }

  var lastWeekData;
  _getSevenDaysData() {
    FirebaseFirestore.instance
        .collection('Order')
        .where('DateTime', isLessThanOrEqualTo: DateTime.now())
        .where('DateTime', isGreaterThanOrEqualTo: seventhday)
        .get()
        .then((value) {
      lastWeekData = value.docs;
      // print(_date(lastWeekData[1]['DateTime'].toDate().toString()));
    }).then((value) {
      _getweeklyorderData();
    });
  }

  var firstdaydata = 0;
  var seconddaydata = 0;
  var thirddaydata = 0;
  var fourthdaydata = 0;
  var fifthdaydata = 0;
  var sixthdaydata = 0;
  var seventhdaydata = 0;
  _getweeklyorderData() {
    for (var i = 0; i < lastWeekData.length; i++) {
      var _data = _date(lastWeekData[i]['DateTime'].toDate().toString());
      if (_data == _date(firstday.toString())) {
        setState(() {
          firstdaydata = firstdaydata + 1;
        });
      } else if (_data == _date(secondday.toString())) {
        setState(() {
          seconddaydata = seconddaydata + 1;
        });
      } else if (_data == _date(thirdday.toString())) {
        setState(() {
          thirddaydata = thirddaydata + 1;
        });
      } else if (_data == _date(fourthday.toString())) {
        setState(() {
          fourthdaydata = fourthdaydata + 1;
        });
      } else if (_data == _date(fifthday.toString())) {
        setState(() {
          fifthdaydata = fifthdaydata + 1;
        });
      } else if (_data == _date(sixthday.toString())) {
        setState(() {
          sixthdaydata = sixthdaydata + 1;
        });
      } else if (_data == _date(seventhday.toString())) {
        setState(() {
          seventhdaydata = seventhdaydata + 1;
        });
      } else {}

      print(_data);
      print(lastWeekData.length.toString());
      print(_date(firstday.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            title: ChartTitle(
                text: 'Weekly Orders analysis',
                textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            // legend: Legend(isVisible: true),
            tooltipBehavior: _tooltipBehavior,

            series: <ChartSeries>[
              SplineSeries<ChartData, String>(
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
                color: Color(0xff00ACFF),
                width: 3,
                opacity: 1,
                // dashArray: <double>[5, 5],
                splineType: SplineType.cardinal,
                cardinalSplineTension: 0.9,
                dataSource: [
                  ChartData(
                      seventhdayname, double.parse(seventhdaydata.toString())),
                  ChartData(
                      sixthdayname, double.parse(sixthdaydata.toString())),
                  ChartData(
                      fifthdayname, double.parse(fifthdaydata.toString())),
                  ChartData(
                      fourthdayname, double.parse(fourthdaydata.toString())),
                  ChartData(
                      thirddayname, double.parse(thirddaydata.toString())),
                  ChartData(
                      seconddayname, double.parse(seconddaydata.toString())),
                  ChartData(firstdayname, double.parse(firstdaydata.toString()))
                ],

                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              )
            ],
            primaryXAxis: CategoryAxis(
              labelStyle: TextStyle(color: Colors.black),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            //   primaryXAxis: NumericAxis(

            //   labelFormat: '{value}',
            //   // isVisible: false,
            //   labelStyle: TextStyle(color: Colors.black),
            //   edgeLabelPlacement: EdgeLabelPlacement.shift,
            // ),
            primaryYAxis: NumericAxis(
              maximum: 5,
              // isVisible: false,
              labelStyle: TextStyle(color: Colors.black),
              labelFormat: '{value}',
            ),
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
