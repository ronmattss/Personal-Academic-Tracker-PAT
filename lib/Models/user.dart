class User {
  // Get User info
  String _lastName;
  String _firstName;
  String _middleName;
  int _age;
  int _profileID;

  User(String lName, String fName, String mName, int age, int profileID) {
    _lastName = lName;
    _firstName = fName;
    _middleName = mName;
    _age = age;
    _profileID = profileID;
  }

  String getName() {
    return _firstName + " " + _middleName + " " + _lastName;
  }

  int getAge() {
    return _age;
  }

  int getProfileID() {
    return _profileID;
  }
}
