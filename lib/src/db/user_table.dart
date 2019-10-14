import 'database.dart';

class UserTableKeys {
  static const kUserId = 'userId';
  static const kFirstName = 'FirstName';
  static const kLastName = 'LastName';
  static const kAge = 'Age';
  static const kDateOfBirth = 'DateOfBirth';
  static const kNationality = 'Nationality';
  static const kIsMarried = 'IsMarried';
}



String userTableCreateQuery = 
      "CREATE TABLE IF NOT EXISTS ${Tables.kUsers} ("
      "${UserTableKeys.kUserId} INTEGER PRIMARY KEY,"
      "${UserTableKeys.kFirstName} TEXT,"
      "${UserTableKeys.kLastName} TEXT,"
      "${UserTableKeys.kAge} INTEGER,"
      "${UserTableKeys.kDateOfBirth} INTEGER,"
      "${UserTableKeys.kNationality} TEXT,"
      "${UserTableKeys.kIsMarried} INTEGER"
      ")";