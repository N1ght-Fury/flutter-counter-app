import 'package:flutter/material.dart';

import './models/counter.dart';

class CounterBuilder extends StatelessWidget {
  final List<Counter> counters;
  final Function updateCounterView;
  CounterBuilder(this.counters, this.updateCounterView);

  Widget _counterBuilder(BuildContext context, int index) {
    return Container(
      child: ButtonTheme(
        minWidth: 225,
        height: 40,
        child: FlatButton(
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          splashColor: Colors.blueAccent,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              this.counters[index].title,
              style: TextStyle(
                  color: Color(0xFFffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          onPressed: () {
            updateCounterView(this.counters[index].id, this.counters[index].title, this.counters[index].value, this.counters[index].increment, this.counters[index].decrement);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildProductList() {
    Widget counterItems = new Container();
    if (counters.length > 0) {
      counterItems = ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: _counterBuilder,
        itemCount: counters.length,
      );
    }
    return counterItems;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
