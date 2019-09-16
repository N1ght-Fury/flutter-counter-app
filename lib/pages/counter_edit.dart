import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/counter.dart';

class CounterEditPage extends StatefulWidget {
  final Counter _counter;
  final Function _updateCounter;
  CounterEditPage(this._counter, this._updateCounter);

  @override
  State<StatefulWidget> createState() {
    return _CounterEditPageState();
  }
}

class _CounterEditPageState extends State<CounterEditPage> {
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
        'Edit counter',
        style: TextStyle(
          color: Color(0xFFffffff),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget._counter.title,
                  selection: TextSelection.collapsed(
                      offset: widget._counter.title.length))),
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
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget._counter.value.toString(),
                  selection: TextSelection.collapsed(
                      offset: widget._counter.value.toString().length))),
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
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget._counter.increment.toString(),
                  selection: TextSelection.collapsed(
                      offset: widget._counter.increment.toString().length))),
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
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: widget._counter.decrement.toString(),
                  selection: TextSelection.collapsed(
                      offset: widget._counter.decrement.toString().length))),
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
            'APPLY',
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
              message = 'Counter updated';
              print(widget._counter.toMap());
              _showToastMessage(message);
              widget._updateCounter(widget._counter);
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
