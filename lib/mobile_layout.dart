˳wimport 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({Key? key}) : super(key: key);

  @override
  _MobileLayoutState createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _returnRateController = TextEditingController();
  final TextEditingController _timePeriodController = TextEditingController();
  double _monthlyInvestment = 25000;
  double _expectedReturnRate = 12;
  double _timePeriod = 10;
  late double _investedAmount;
  late double _totalInvestment;
  late double _result;
  late double i;

  @override
  void initState() {
    _controller.text = _monthlyInvestment.toString();
    _returnRateController.text = _expectedReturnRate.toString();
    _timePeriodController.text = _timePeriod.toString();
    _investedAmount = (_monthlyInvestment * 12) * _timePeriod;

    i = (_expectedReturnRate) / (12 * 100);

    _result = (_monthlyInvestment *
            (((pow((1 + i), (_timePeriod * 12))) - 1) / i) *
            (1 + i)) -
        _investedAmount;

    _totalInvestment = _investedAmount + _result;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 100),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF98a4ff),
                  ),
                ),
                const SizedBox(width: 3),
                const Text('Invested amount'),
                const SizedBox(width: 30),
                Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF5367ff),
                  ),
                ),
                const SizedBox(width: 3),
                const Text('Estd. returns'),
              ],
            ),
          ),
          const SizedBox(height: 50),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 30,
                useRangeColorForAxis: true,
                startAngle: 270,
                endAngle: 270,
                showLabels: false,
                showTicks: false,
                axisLineStyle: const AxisLineStyle(
                    thicknessUnit: GaugeSizeUnit.factor,
                    thickness: 0.35,
                    color: Color(0xFF98a4ff)),
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 17,
                      color: const Color(0xFF98a4ff),
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.35,
                      endWidth: 0.35),
                  GaugeRange(
                      startValue: _expectedReturnRate,
                      endValue: 30,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: const Color(0xFF5367ff),
                      startWidth: 0.35,
                      endWidth: 0.35),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            child: const Text('INVEST NOW'),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20.0),
                primary: Colors.greenAccent,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Monthly Investment',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffe5faf5),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 30),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: 5,
                    inactiveTrackHeight: 5,
                    activeTrackColor: const Color(0xff00d09c),
                    inactiveTrackColor: Colors.black12,
                    thumbColor: Colors.white,
                    trackCornerRadius: 0,
                    thumbRadius: 15,
                  ),
                  child: SfSlider(
                      min: 500,
                      max: 100000,
                      value: _monthlyInvestment,
                      onChanged: (dynamic value) {
                        setState(() {
                          _monthlyInvestment = value;
                          _controller.text =
                              _monthlyInvestment.toStringAsFixed(0);
                          _investedAmount =
                              (_monthlyInvestment * 12) * _timePeriod;
                          i = (_expectedReturnRate) / (12 * 100);
                          _result = (_monthlyInvestment *
                                  (((pow((1 + i), (_timePeriod * 12))) - 1) /
                                      i) *
                                  (1 + i)) -
                              _investedAmount;
                          _totalInvestment = _investedAmount + _result;
                        });
                      }),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Expected return rate (p.a)',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _returnRateController,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffe5faf5),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 30),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: 5,
                    inactiveTrackHeight: 5,
                    activeTrackColor: const Color(0xff00d09c),
                    inactiveTrackColor: Colors.black12,
                    thumbColor: Colors.white,
                    trackCornerRadius: 0,
                    thumbRadius: 15,
                  ),
                  child: SfSlider(
                      min: 1,
                      max: 30,
                      value: _expectedReturnRate,
                      onChanged: (dynamic value) {
                        setState(() {
                          _expectedReturnRate = value;
                          _returnRateController.text =
                              _expectedReturnRate.toStringAsFixed(0);
                          i = (_expectedReturnRate) / (12 * 100);
                          _result = (_monthlyInvestment *
                                  (((pow((1 + i), (_timePeriod * 12))) - 1) /
                                      i) *
                                  (1 + i)) -
                              _investedAmount;
                          _totalInvestment = _investedAmount + _result;
                        });
                      }),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Time period',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _timePeriodController,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffe5faf5),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 30),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: 5,
                    inactiveTrackHeight: 5,
                    activeTrackColor: const Color(0xff00d09c),
                    inactiveTrackColor: Colors.black12,
                    thumbColor: Colors.white,
                    trackCornerRadius: 0,
                    thumbRadius: 15,
                  ),
                  child: SfSlider(
                      min: 1,
                      max: 30,
                      value: _timePeriod,
                      onChanged: (dynamic value) {
                        setState(() {
                          _timePeriod = value;
                          _timePeriodController.text =
                              _timePeriod.toStringAsFixed(0);
                          _investedAmount =
                              (_monthlyInvestment * 12) * _timePeriod;
                          i = (_expectedReturnRate) / (12 * 100);
                          _result = (_monthlyInvestment *
                                  (((pow((1 + i), (_timePeriod * 12))) - 1) /
                                      i) *
                                  (1 + i)) -
                              _investedAmount;
                          _totalInvestment = _investedAmount + _result;
                        });
                      }),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Invested Amount'),
                      Text(
                        _investedAmount.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Est. returns'),
                      Text(
                        _result.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total value'),
                      Text(
                        _totalInvestment.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
