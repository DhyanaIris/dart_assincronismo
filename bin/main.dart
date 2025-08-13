import 'package:http/http.dart';
import 'dart:convert';

void main() {
  // print("Olá, mundo!");
  // requestData();
  requestDataAsync();
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

requestDataAsync() async {
  String url = "https://gist.githubusercontent.com/DhyanaIris/2e66db149ff642f73de2b78314c7e84f/raw/7e77d90439ec0c4e0df3d4395696235a973ff831/accounts.json";
  Response response = await get(Uri.parse(url));
  print(json.decode(response.body)[0]);
  print("De fato, a última coisa a acontecer na função.");
}