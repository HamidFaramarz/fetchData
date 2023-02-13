class Users {
  int _id;
  String _name;
  String _email;
  String _password;

  Users(this._id, this._name, this._email, this._password);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get email => _email;

  set email(String email) {
    _email = email;
  }

  String get password => _password;

  set password(String password) {
    _password = password;
  }
}
