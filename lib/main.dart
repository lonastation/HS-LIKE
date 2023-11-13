import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP title',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HS-LIKE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _now = '';
  String _result = 'Not start yet';
  String _desc = '';

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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      calculate();
    });
  }

  void calculate() {
    DateTime now = DateTime.now();
    Lunar date = Lunar.fromDate(now);
    var hourIndex = getChineseHour(now.hour);
    var chineseHour = hour12[hourIndex];
    var first = date.getMonth() % 6 - 1;
    var second = date.getDay() % 6 - 1;
    var third = hourIndex % 6;
    var index = (first + second + third) % 6;
    _now =
        wrapDate(date.getMonthInChinese(), date.getDayInChinese(), chineseHour);
    _result = liu[index];
    _desc = liuDesc[index];
  }

  String getChineseCalendar() {
    DateTime now = DateTime.now();
    var chineseHour = hour12[getChineseHour(now.hour)];
    Lunar date = Lunar.fromDate(now);
    return wrapDate(date.getMonthInChinese(), date.getDayInChinese(), chineseHour);
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '不诚不占，不义不占，不疑不占',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _now,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
            Text(
              '测算结果：',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _result,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
            Text(
              '结果解析：',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              _desc,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
