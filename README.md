# Flutter Webservice, JSON, Data Model, SQLite - Full flow sample


## Getting Started

```Dart
  final postData = {'token': 'tokenId'};
  final header = {'header1key' : 'header1val'};
  NetworkAPI().httpPostRequest('getUsers/', headers, postData, (status, response){

      if (status == true) {
        for (var user in response) {
          Users u =  Users.fromMap(user);
          Users.insert(u); //insert to SQLite table
        }
      }
      else{}
    });
```
