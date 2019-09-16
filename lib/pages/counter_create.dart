import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/counter.dart';

class CounterCreatePage extends StatefulWidget {
  final Counter _counter;
  final Function _addCounter;

  CounterCreatePage(this._addCounter, this._counter);
  
  @override
  State<StatefulWidget> createState() {
    return _CounterCreatePageState();
  }
}

class _CounterCreatePageState extends State<CounterCreatePage> {
  void _showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Widget _showDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF424242),
      title: Text(
        'Add new counter',
        style: TextStyle(
          color: Color(0xFFffffff),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Color(0xFFe0e0e0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8cdbca),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
              maxLength: 12,
              onChanged: (String value) {
                widget._counter.title = value;
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Value',
                labelStyle: TextStyle(
                  color: Color(0xFFe0e0e0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8cdbca),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                if (value.isEmpty) {
                  widget._counter.value = 0;
                }
                else {
                  widget._counter.value = int.parse(value);
                }
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Increment',
                labelStyle: TextStyle(
                  color: Color(0xFFe0e0e0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8cdbca),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                if (value.isEmpty) {
                  widget._counter.increment = 1;
                }
                else {
                  widget._counter.increment = int.parse(value);
                }
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Decrement',
                labelStyle: TextStyle(
                  color: Color(0xFFe0e0e0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF8cdbca),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                if (value.isEmpty) {
                  widget._counter.decrement = 1;
                }
                else {
                  widget._counter.decrement = int.parse(value);
                }
              },
            ),
            Container(
              height: 1,
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(
              color: Color(0xFF8cdbca),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            'ADD',
            style: TextStyle(
              color: Color(0xFF8cdbca),
            ),
          ),
          onPressed: () {
            String message = '';

            if (widget._counter.title == '') {
              message = 'Title cant be null';
              Navigator.pop(context);
              _showToastMessage(message);
            } else {
              message = 'Counter added';
              widget._addCounter(widget._counter);
              _showToastMessage(message);
              Navigator.pop(context, true);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _showDialog(context);
  }
}
