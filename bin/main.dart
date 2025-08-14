import 'dart:async';

import 'package:dart_assincronismo/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

StreamController<String> streamController = StreamController<String>();

void main() {

  Map<String, dynamic> mapAccount = {
    "id": "NEW001",
    "name": "Flutter",
    "lastName": "Dart",
    "balance": 5000
  };
  sendDataAsync(mapAccount);
}

requestData() {
  String url = "https://gist.githubusercontent.com/DhyanaIris/2e66db149ff642f73de2b78314c7e84f/raw/7e77d90439ec0c4e0df3d4395696235a973ff831/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then(
    (Response response) {
      print(response.body);
      List<dynamic> listAccounts = json.decode(response.body);
      Map<String, dynamic> mapCarla = listAccounts.firstWhere(
        (element) => element["name"] == "Carla",
      );
      print(mapCarla["balance"]);
    },
  );
  print("Última coisa a acontecer na função.");
}

Future<List<dynamic>> requestDataAsync() async {
  String url = "https://gist.githubusercontent.com/DhyanaIris/2e66db149ff642f73de2b78314c7e84f/raw/7e77d90439ec0c4e0df3d4395696235a973ff831/accounts.json";
  Response response = await get(Uri.parse(url));
  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);
  
  String url = "https://api.github.com/gists/2e66db149ff642f73de2b78314c7e84f";
  Response response = await post(
    Uri.parse(url), 
    headers: {
      "Authorization": "Bearer $githubApiKey"
    }, 
    body: json.encode({
      "description": "account.json",
      "public": true,
      "files": {
        "accounts.json": {
          "content": content,
        }
      }
    }),
  );
  print(response.statusCode);
}