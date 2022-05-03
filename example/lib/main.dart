import 'package:example/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter candlestick',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0b112e),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF0b112e), elevation: 0)),
      home: const MyHomePage(title: 'Flutter candlestick'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    const style = CandlestickChartStyle(
        yLegendStyle: CandlestickChartYLegendStyle(
            textStyle: TextStyle(color: Colors.white),
            numberOfLabels: 5,
            lineStyle: CandlestickChartLineStyle(width: 1, color: Colors.white)),
        candlestickStyle: CandlestickStyle(bullishColor: Color(0xFF38bbbf), bearishColor: Color(0xFFed7b9e)),
        candlestickSelectedStyle: CandlestickStyle(bullishColor: Color(0xff25787b), bearishColor: Color(0xff9d4963)));

    const style2 = CandlestickChartStyle(
        yLegendStyle: CandlestickChartYLegendStyle(
            textStyle: TextStyle(color: Colors.white),
            numberOfLabels: 5,
            lineStyle: CandlestickChartDashedLineStyle(width: 1, color: Colors.white)),
        candlestickStyle: CandlestickStyle(bullishColor: Color(0xFF38bbbf), bearishColor: Color(0xFFed7b9e)),
        candlestickSelectedStyle: CandlestickStyle(bullishColor: Color(0xff25787b), bearishColor: Color(0xff9d4963)));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CandlesticksChart<CandleModel>(
                height: 200,
                data: data,
                style: style,
                options: const CandlestickChartOptions(isScrollable: true),
                getHightCallback: (e) => e.hight,
                getCloseCallback: (e) => e.close,
                getLowCallback: (e) => e.low,
                getOpenCallback: (e) => e.open,
                getTimeCallback: (e) => e.date,
              ),
              CandlesticksChart<CandleModel>(
                height: 200,
                data: data,
                style: style2,
                getHightCallback: (e) => e.hight,
                getCloseCallback: (e) => e.close,
                getLowCallback: (e) => e.low,
                getOpenCallback: (e) => e.open,
                getTimeCallback: (e) => e.date,
              )
            ],
          ),
        ),
      ),
    );
  }
}
