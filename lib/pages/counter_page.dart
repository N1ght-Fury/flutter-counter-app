import 'package:counter_app_v2/pages/counter_delete.dart';
import 'package:flutter/material.dart';

import '../models/counter.dart';
import '../counter_builder.dart';
import './counter_create.dart';
import './counter_reset.dart';
import './counter_edit.dart';

class CounterPage extends StatelessWidget {
  final List<Counter> _counters;
  final Function _addCounter;
  final Function _updateCounter;
  final Function _deleteCounter;
  final Function _updateCounterView;
  final Function _updateCounterList;
  final Function _increaseValue;
  final Function _decreaseValue;

  final int id;
  final String title;
  final int value;
  final int increment;
  final int decrement;

  CounterPage(this._counters, this._addCounter, this._updateCounter,this._deleteCounter, this._updateCounterView, this._updateCounterList, this._increaseValue, this._decreaseValue
      ,{this.id, this.title, this.value, this.increment, this.decrement});

  @override
  Widget build(BuildContext context) {
    
    
    //_updateCounterList();
    
    print(id);
    print(title);
    print(value);
    print(increment);
    print(decrement);
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFF303030),
      drawer: SizedBox(
        width: 225,
        child: Drawer(
          child: Container(
            color: Color(0xFF111111),
            child: Column(
              children: <Widget>[
                //Drawer
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Counter'),
                ),
                Container(
                  child: ButtonTheme(
                    minWidth: 225,
                    height: 50,
                    child: FlatButton(
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      splashColor: Colors.blueAccent,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '+  Add Counter',
                          style: TextStyle(
                              color: Color(0xFFffffff),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      //padding: EdgeInsets.only(left: 5),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Counter _counter;
                            return CounterCreatePage(_addCounter, _counter);
                          },
                        );
                      },
                    ),
                  ),
                ),

                Divider(
                  height: 2.0,
                  color: Color(0xFFffffff),
                ),
                //Counter List
                Expanded(
                  child: CounterBuilder(_counters, _updateCounterView),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CounterResetPage();
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CounterEditPage(Counter.withId(id, title, value, increment, decrement),_updateCounter);
                },
              );
            },
          ),
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Color(0xFF303030),
            ),
            child: PopupMenuButton(
              icon: Icon(
                Icons.settings,
                color: Color(0xFFffffff),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    'Delete Counter',
                    style: TextStyle(color: Color(0xFFffffff)),
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    'Settings',
                    style: TextStyle(color: Color(0xFFffffff)),
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CounterDeletePage(_deleteCounter, id);
                    },
                  );
                } else if (value == 2) {
                  Navigator.pushNamed(context, 'settings');
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
          ),
          Center(
            child: SizedBox(
              width: 300,
              height: 250,
              child: Center(
                child: Text(
                  value.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFffffff),
                      fontSize: 120),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
          ),
          ButtonTheme(
            minWidth: 320.0,
            height: 120.0,
            child: FlatButton(
              color: Color(0xFF5A5A5C),
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blueAccent,
              onPressed: () {
                _increaseValue(_counters[0]);
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 70.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
          ),
          ButtonTheme(
            minWidth: 320.0,
            height: 60.0,
            child: FlatButton(
              color: Color(0xFF5A5A5C),
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blueAccent,
              onPressed: () {
                _decreaseValue(_counters[0]);
              },
              child: Text(
                "-",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
