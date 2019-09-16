import 'package:flutter/material.dart';

class CounterResetPage extends StatelessWidget {
  Widget _showDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF424242),
      content: Text(
        'Do you really wish to reset this counter?',
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
            'RESET COUNTER',
            style: TextStyle(
              color: Color(0xFF8cdbca),
            ),
          ),
          onPressed: () {
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
