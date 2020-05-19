import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;


class TasksApiProvider {
  Client client = Client();
  final _apiKey = 'api-key';
  final _baseUrl = "https://1devfull.info/inner/tza/app.php?cmd=task/list";

  Future<int> fetchMovieList() async {
    Response response;
//    if(_apiKey != 'api-key') {
      response = await client.get("$_baseUrl");
//    }else{
//      throw Exception('Please add your API key');
//    }
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<Map<String, dynamic>> listmaps= [];
      List<dynamic> datalist = json.decode(response.body);
      datalist.forEach((element) {
        listmaps.add(element);
      });
      return 1;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}