import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class News {
  String imageUrl, date, title, shortDescription, description;
  List<String> attachmentList;
  News(this.imageUrl, this.date, this.title, this.shortDescription, this.description,
      this.attachmentList);

  static Future<List<News>> getDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<News> getOneNews({newsId}) async {
    print('NEWS ID IN getOneNews: ' + newsId.toString());
    dynamic data = json.decode(await getDataById(newsId));
    print("_____________________________--");
    print(data);
    return getSingleNewsFromJson(data);
  }

  static Future<News> getOne() async {
    return (await getDummyList())[0];
  }

  static News fromJson(Map<String, dynamic> jsonObject) {
    List<String> attachmentList = [];
    String imageUrl = '';
    if (jsonObject['CoverPhotoPath'] != "null") {
      imageUrl = jsonObject['CoverPhotoPath'].toString();
    } else {
      imageUrl = '';
      // print('No Photo: ' + jsonObject['Title']);
    }
    String date = jsonObject['CreatedOn'].toString();
    DateTime dateTime = DateTime.parse(date);
    // print(dateTime);
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(dateTime);
    // print(outputDate);
    String title = jsonObject['Title'].toString();
    String shortDescription = jsonObject['Description'].toString();
    String description = jsonObject['HtmlContent'].toString();
    for (var i = 0; i < jsonObject['Attachement'].length; i++) {
      // print("jsonObject['Attachement'][i]['Path']");
      // print(jsonObject['Attachement'][i]['Path']);
      attachmentList.add(jsonObject['Attachement'][i]['Path']);
    }
    return News(imageUrl, outputDate, title, shortDescription, description, attachmentList);
  }

  static List<News> getListFromJson(Map<String, dynamic> jsonArray) {
    List<News> list = [];
    for (int i = 0; i < jsonArray["Result"].length; i++) {
      list.add(News.fromJson(jsonArray["Result"][i]));
    }
    return list;
  }

  static News getSingleNewsFromJson(Map<String, dynamic> jsonArray) {
    print("getSingleNewsFromJson");
    print(jsonArray['Result']['Title']);
    print(jsonArray['Result']['Id']);

    return News.fromJson(jsonArray["Result"]);
  }

  static Future<String> getData(pageSize, pageNumber) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL +
        'News/GetNewsPaging?pageSize=' +
        pageSize.toString() +
        '&pageNumber=' +
        pageNumber.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getData : "+pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getDataById(newsID) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL + 'News/' + newsID.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("getDataOne NEWS : ");
      print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  @override
  String toString() {
    return 'News{imageUrl: $imageUrl, date: $date, title: $title, shortDescription: $shortDescription}';
  }
}
