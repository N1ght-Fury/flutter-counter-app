import 'package:flutter/material.dart';

class CounterDeletePage extends StatelessWidget {
  
  final Function _deleteCounter;
  final int _id;
  CounterDeletePage(this._deleteCounter, this._id);
  
  Widget _showDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF424242),
      content: Text(
        'Do you really wish to delete this counter?',
        style: TextStyle(
          color: Color(0xFFffffff),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(20,15,0,0),
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
            'DELETE COUNTER',
            style: TextStyle(
              color: Color(0xFF8cdbca),
            ),
          ),
          onPressed: () {
            _deleteCounter(_id);
            print(_id);
            Navigator.pop(context,true);
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
