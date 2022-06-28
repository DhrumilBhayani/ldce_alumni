import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:ldce_alumni/core/globals.dart' as globals;

class Noteworthy {
  String coverPhoto, title, shortDescription, description, alumniName, alumniPassoutYear, alumniBranch;

  Noteworthy(this.coverPhoto, this.title, this.shortDescription, this.description, this.alumniName,
      this.alumniBranch, this.alumniPassoutYear);

  static Future<List<Noteworthy>> getDummyList({pageNumber = 1, pageSize = 5}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data['Result']);
  }

  static Future<Noteworthy> getOne() async {
    return (await getDummyList())[0];
  }

  static Noteworthy fromJson(Map<String, dynamic> jsonObject) {
    String coverPhoto = jsonObject['CoverPhotoPath'].toString();
    String title = jsonObject['Title'].toString();
    String shortDescription = jsonObject['Description'].toString();
    String description = jsonObject['HtmlContent'].toString();
    String alumniName = jsonObject['AlumniName'].toString();
    String alumniBranch = jsonObject['AlumniBranch'].toString();
    String alumniPassoutYear = jsonObject['AlumniPassoutYear'].toString();
    return Noteworthy(
        coverPhoto, title, shortDescription, description, alumniName, alumniBranch, alumniPassoutYear);
  }

  static List<Noteworthy> getListFromJson(List<dynamic> jsonArray) {
    List<Noteworthy> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Noteworthy.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData(pageSize, pageNumber) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL +
        'Achievements/GetAchievementPaging?pageSize=' +
        pageSize.toString() +
        '&pageNumber=' +
        pageNumber.toString());

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        
        return response.body;
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    } 
      return '';
     // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  // static Future<String> getData(pageSize, pageNumber) async {
  //   //dynamic myJson = await rootBundle.loadString('news.json');
  //   //print(myJson);
  //   // https://ldcealumniapi.devitsandbox.com/api/Events/GetEventPaging?pageSize=5&pageNumber=1
  //   return await rootBundle.loadString('lib/models/noteworthy/noteworthy.json');
  //   // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  // }

  @override
  String toString() {
    return 'NoteWorthy{coverPhoto: $coverPhoto, title: $title, description: $description}';
  }
}
