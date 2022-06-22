import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ld_alumni/core/globals.dart' as globals;

class Home {
  String imageUrl;

  Home(this.imageUrl);

  static Future<List<Home>> getDummyList() async {
    dynamic data = json.decode(await getData());
    // print("_____________________________--");
    // print(data['Result']);
    return getListFromJson(data);
  }

  static Future<Home> getOne() async {
    return (await getDummyList())[0];
  }

  static Home fromJson(imageUrl) {
    // String imageUrl = jsonObject['Result'].toString();

    return Home(imageUrl);
  }

  static List<Home> getListFromJson(Map<String, dynamic> jsonArray) {
    List<Home> list = [];
    for (int i = 0; i < jsonArray["Result"].length; i++) {
      list.add(Home.fromJson(jsonArray["Result"][i]));
    }
    return list;
  }

  static Future<String> getData() async {
    //dynamic myJson = await rootBundle.loadString('news.json');
    // print("Hello");
    var url = Uri.parse(globals.BASE_API_URL + 'Slider');
    try {
      var response = await http.get(url).timeout(Duration(seconds: globals.timeout));

      return response.body;
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
    // if (response.statusCode == 200) {
    //   // print(response.body);
    //   // dynamic data = json.decode(response.body);
    //   // print(data["Result"][0]);
    // }
    // return await rootBundle.loadString('lib/models/home/home.json');
    return "response.body";
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  @override
  String toString() {
    return 'Home{imageUrl: $imageUrl}';
  }
}
