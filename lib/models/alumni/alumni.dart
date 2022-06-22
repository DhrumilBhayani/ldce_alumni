import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ld_alumni/core/globals.dart' as globals;

class Alumni {
  String name, passoutYear, program, branch, membership, profession;

  Alumni(
    this.name,
    this.passoutYear,
    this.program,
    this.branch,
    this.membership,
    this.profession,
  );

  static Future<List<Alumni>> getDummyList({pageSize = 25, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<List<Alumni>> getSearchResult(
      {name = "", passoutYear = "", degree = "", branch = "", membershipType = ""}) async {
    print("_____________________________--");
    dynamic data = json.decode(await getSearchResultData(
        name: name,
        passoutYear: passoutYear,
        degree: degree,
        branch: branch,
        membershipType: membershipType));
    print(data);
    return getListFromJson(data);
  }

  static Future<Alumni> getOne() async {
    return (await getDummyList())[0];
  }

  static Alumni fromJson(Map<String, dynamic> jsonObject) {
    String name = jsonObject['FullName'].toString();
    String passoutYear = jsonObject['PassoutYear'].toString();
    String program = jsonObject['Program'].toString();
    String branch = jsonObject['Branch'].toString();
    String membership = jsonObject['Membership'].toString();
    String profession = jsonObject['CompanyName'].toString();
    // String email = jsonObject['email'].toString();

    return Alumni(name, passoutYear, program, branch, membership, profession);
  }

  static List<Alumni> getListFromJson(Map<String, dynamic> jsonArray) {
    print("object");
    List<Alumni> list = [];
    for (int i = 0; i < jsonArray["Result"].length; i++) {
      list.add(Alumni.fromJson(jsonArray["Result"][i]));
    }
    return list;
  }

  static Future<String> getData(pageSize, pageNumber) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL +
        '/Alumni/GetAlumniDirectoryPaging?pageSize=' +
        pageSize.toString() +
        '&pageNumber=' +
        pageNumber.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getData : "+pageNumber.toString());
      print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // return await rootBundle.loadString('lib/models/alumni/alumni.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getSearchResultData(
      {name = "", passoutYear = "", degree = "", branch = "", membershipType = ""}) async {
    if (name == null) {
      name = "";
    }
    if (passoutYear == null || passoutYear == 'All') {
      passoutYear = "";
    }
    if (degree == null) {
      degree = "";
    }
    if (branch == null || branch == 'All') {
      branch = "";
    }
    if (membershipType == null) {
      membershipType = "";
    }
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);
// https://ldcealumniapi.devitsandbox.com/api/Alumni/SearchAlumni?name=akash&passoutYear=&degree=&branch=&membershipType=
    var url = Uri.parse(globals.BASE_API_URL +
        '/Alumni/SearchAlumni?name=' +
        name +
        '&passoutYear=' +
        passoutYear.toString() +
        '&degree=' +
        degree.toString() +
        '&branch=' +
        branch.toString() +
        '&membershipType=' +
        membershipType.toString());
    print(url.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getData : "+pageNumber.toString());
      print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // return await rootBundle.loadString('lib/models/alumni/alumni.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  @override
  String toString() {
    return 'Alumni{imageUrl: $name, date: $passoutYear, title: $name, shortDescription: $name}';
  }
}
