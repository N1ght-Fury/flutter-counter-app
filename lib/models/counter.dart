
class Counter {
  int _id;
  String _title;
  int _value;
  int _increment;
  int _decrement;

  Counter(this._title,this._value,this._increment,this._decrement);
  Counter.withId(this._id,this._title,this._value,this._increment,this._decrement);

  int get id => _id;
  String get title => _title;
  int get value => _value;
  int get increment => _increment;
  int get decrement => _decrement;

  set title(String newTitle) {
    this._title = newTitle;
  }

  set value(int newValue) {
    this._value = newValue;
  }

  set increment(int newIncrement) {
    this._increment = newIncrement;
  }

  set decrement(int newDecrement) {
    this._decrement = newDecrement;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    //checking id here bcz if its null it means
    //the operation is insert, if its not null
    //it means we are doing update
    if (id != null) {
      map['id'] = id;
    }

    map['title'] = title;
    map['value'] = value;
    map['increment'] = increment;
    map['decrement'] = decrement;

    return map;
  }

  Counter.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._value = map['value'] ;
    this._increment = map['increment'];
    this._decrement = map['decrement'];
  }

}