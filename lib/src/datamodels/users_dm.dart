import 'package:flutter_webservice_sample/src/db/database.dart';
import 'package:sqflite/sqflite.dart';

import '../networking/get_user_service.dart';
import '../networking/network_api.dart';
import '../db/user_table.dart';

class Users  {
  int? userId;
  String? firstName;
  String? lastName;
  int? age;
  int? dateOfBirth;
  String? nationality;
  int? isMarried;

  static syncUsers () {

    NetworkAPI().httpPostRequest('getUsers/', null, {'token': 'tokenId'}, (status, response){

      if (status) {
        for (var user in response!) {
          Users u =  Users.fromMap(user);
          Users.insert(u);
        }
      }
      else
      {

      }

    });

  }

  Users({
    this.userId,
    this.firstName,
    this.lastName,
    this.age,
    this.dateOfBirth,
    this.nationality,
    this.isMarried
  });

  factory Users.fromMap(Map<String, dynamic> json) => new Users (
    userId: json[UserTableKeys.kUserId],
    firstName: (json[UserTableKeys.kFirstName] != null) ?json[UserTableKeys.kFirstName] : "",
    lastName:  (json[UserTableKeys.kLastName] != null) ?json[UserTableKeys.kLastName] : "",
    age:  json[UserTableKeys.kAge],
    dateOfBirth: json[UserTableKeys.kDateOfBirth],
    nationality:  (json[UserTableKeys.kNationality] != null) ?json[UserTableKeys.kNationality] : "",
    isMarried: json[UserTableKeys.kIsMarried]
  );

  Map<String, dynamic> toMap() => {
    UserTableKeys.kUserId:  userId,
    UserTableKeys.kFirstName: firstName,
    UserTableKeys.kLastName: lastName,
    UserTableKeys.kAge: age,
    UserTableKeys.kDateOfBirth: dateOfBirth,
    UserTableKeys.kNationality: nationality,
    UserTableKeys.kIsMarried: isMarried  
  };
  
  static insert(Users model) async {

    Database db = PersistentStore.defaultStore.db!;

    var query = await db.rawQuery(
      "INSERT OR REPLACE INTO  ${Tables.kUsers}" 
      "(${UserTableKeys.kUserId}, ${UserTableKeys.kFirstName}, ${UserTableKeys.kLastName}," 
      "${UserTableKeys.kAge},  ${UserTableKeys.kDateOfBirth}, ${UserTableKeys.kNationality}," 
      "${UserTableKeys.kIsMarried})"
      " VALUES (?,?,?,?,?,?,?)", 
      [
        model.userId,
        model.firstName,
        model.lastName,
        model.age,
        model.dateOfBirth,
        model.nationality,
        model.isMarried
      ]);
    return query;
  }
  
  static update(Users model) async {

    Database db = PersistentStore.defaultStore.db!;

    var result = await db.update("${Tables.kUsers}", model.toMap(),
    where: "${UserTableKeys.kUserId} = ?", whereArgs: [model.userId]);
    return result;
  }

  static deleteRecord(int id) async {
    Database db = PersistentStore.defaultStore.db!;

    return db.delete("${Tables.kUsers}", where: "${UserTableKeys.kUserId} = ?", whereArgs: [id]);
  }
}

