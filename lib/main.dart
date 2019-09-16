import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import './pages/counter_page.dart';
import './pages/settings_page.dart';
import './models/counter.dart';
import './utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Counter> _counters = List<Counter>();

  int _id;
  String _title;
  int _value;
  int _increment;
  int _decrement;

  static int _lastIndex;

  @override
  void initState() {
    super.initState();
    print('[initState] Set state');
    _updateCounterList().then((counter) {
      setState(() {
        _updateCounterView(counter.id, counter.title, counter.value,
            counter.increment, counter.decrement);
      });
    });
  }

  void _updateCounterView(
      int id, String title, int value, int increment, int decrement) {
    print('[_updateCounterView] Set state');
    _id = id;
    _title = title;
    _value = value;
    _increment = increment;
    _decrement = decrement;
  }

//_updateCounterView(_counters[0].id, _counters[0].title, _counters[0].value, _counters[0].increment, _counters[0].decrement);
  Future<Counter> _updateCounterList() async {
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Counter>> counterListFuture =
          _databaseHelper.getCounterList();
      counterListFuture.then((counterList) {
        setState(() {
          print('[_updateCounterList] Set state');
          this._counters = counterList;
          _updateCounterView(
              _counters[0].id,
              _counters[0].title,
              _counters[0].value,
              _counters[0].increment,
              _counters[0].decrement);
        });
      });
    });
    return this._counters[0];
  }

  void _addCounter(Counter counter) async {
    await _databaseHelper.insertCounter(counter);
    setState(() {
      _updateCounterList();
      //_updateCounterView(counter.id, counter.title, counter.value,counter.increment, counter.decrement);
    });
  }

  void _deleteCounter(int id) async {
    setState(() async {
      int result = await _databaseHelper.deleteCounter(id);
      print('id:' + _id.toString());
      print('result:' + result.toString());
      if (result != 0) {
        setState(() {
          _updateCounterList();
        });
      }
    });
  }

  void _updateCounter(Counter counter) async {
    await _databaseHelper.updateCounter(counter);
    setState(() {
      _updateCounterList();
      //_updateCounterView(counter.id, counter.title, counter.value, counter.increment, counter.decrement);
    });
  }

  void _increaseValue(Counter counter) {
    counter.value += counter.increment;
    setState(() {
      _updateCounter(counter);
    });
  }

  void _decreaseValue(Counter counter) {
    counter.value -= counter.decrement;
    setState(() {
      _updateCounter(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF212121),
      ),
      routes: {
        '/': (BuildContext context) => CounterPage(
              this._counters,
              _addCounter,
              _updateCounter,
              _deleteCounter,
              _updateCounterView,
              _updateCounterList,
              _increaseValue,
              _decreaseValue,
              id: _id,
              title: _title,
              value: _value,
              increment: _increment,
              decrement: _decrement,
            ),
        'settings': (BuildContext context) => SettingsPage(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
            builder: (BuildContext context) => CounterPage(
                  _counters,
                  _addCounter,
                  _updateCounter,
                  _deleteCounter,
                  _updateCounterView,
                  _updateCounterList,
                  _increaseValue,
                  _decreaseValue,
                  id: _id,
                  title: _title,
                  value: _value,
                  increment: _increment,
                  decrement: _decrement,
                ));
      },
    );
  }
}
