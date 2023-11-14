import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP title',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HS-LIKE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _now = '';
  String _result = 'Not Start Yet';
  String _desc = '动心起念即为征兆';

  var hour12 = [
    '子',
    '丑',
    '寅',
    '卯',
    '辰',
    '巳',
    '午',
    '未',
    '申',
    '酉',
    '戌',
    '亥',
    '异常'
  ];
  var liu = ['大安', '流连', '速喜', '赤口', '小吉', '空亡', '异常'];
  var liuDesc = [
    '健康平安，事情发展顺利，心想事成',
    '流连忘返，事情不顺利，不会有结果，要等的人也不会来，此时不宜轻举妄动',
    '很快会有喜讯传来，会有好结果',
    '口舌是非，容易遇到小人，尤其不利于谈事情',
    '吉祥如意，事情顺利',
    '诸事不顺，会有坏的结果，及时止损',
    '异常'
  ];

  void _calculate() {
    setState(() {
      DateTime now = DateTime.now();
      Lunar date = Lunar.fromDate(now);
      var hourIndex = getChineseHour(now.hour);
      var chineseHour = hour12[hourIndex];
      var index =
          (date.getMonth() % 6 - 1 + date.getDay() % 6 - 1 + hourIndex % 6) % 6;
      _now = wrapDate(
          date.getMonthInChinese(), date.getDayInChinese(), chineseHour);
      _result = '测算结果： ${liu[index]}';
      _desc = liuDesc[index];
    });
  }

  String getChineseCalendar() {
    DateTime now = DateTime.now();
    var chineseHour = hour12[getChineseHour(now.hour)];
    Lunar date = Lunar.fromDate(now);
    return wrapDate(
        date.getMonthInChinese(), date.getDayInChinese(), chineseHour);
  }

  String wrapDate(String month, String day, String hour) {
    return '$month月$day日$hour时';
  }

  int getChineseHour(int hour) {
    return ((hour + 1) ~/ 2) % 12;
  }

  @override
  Widget build(BuildContext context) {
    _now = getChineseCalendar();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        title: Text(widget.title),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg-tarot.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.purple.withOpacity(0.2)),
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: const EdgeInsets.fromLTRB(0, 140, 0, 0),
              child: const Text(
                '不诚不占，不义不占，不疑不占',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Text(
                _now,
                style:
                    const TextStyle(color: Colors.yellowAccent, fontSize: 22),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                _result,
                style:
                    const TextStyle(color: Colors.yellowAccent, fontSize: 22),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
              child: Text(
                _desc,
                style: const TextStyle(
                    color: Colors.yellowAccent, fontSize: 22, height: 1.5),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: FilledButton(
                onPressed: _calculate,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.white.withOpacity(0.2)),
                    alignment: Alignment.center,
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.fromLTRB(100, 14, 100, 16))),
                child: const Text('测算',
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
