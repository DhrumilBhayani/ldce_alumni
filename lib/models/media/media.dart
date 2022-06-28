import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;
import 'dart:async';
import 'dart:io';

class Media {
  String coverPhoto, date, title, shortDescription, description;
  List<dynamic> imageList;
  Media(
    this.coverPhoto,
    this.imageList,
    this.date,
    this.title,
    this.shortDescription,
    this.description,
  );

  static Future<List<Media>> getDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________ Media ________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<Media> getOne() async {
    return (await getDummyList())[0];
  }

  static Media fromJson(Map<String, dynamic> jsonObject) {
    String coverPhoto = jsonObject['CoverPhotoPath'].toString();
    List<dynamic> imageList = jsonObject['Attachement'];
    String date = jsonObject['CreatedOn'].toString();
    print("Attachments:");
    for (var i = 0; i < imageList.length; i++) {
      print(imageList[i]["Path"]);
    }
    String title = jsonObject['Title'].toString();
    String shortDescription = jsonObject['Description'].toString();
    String description = jsonObject['HtmlContent'].toString();

    return Media(coverPhoto, imageList, date, title, shortDescription, description);
  }

  static List<Media> getListFromJson(Map<String, dynamic> jsonArray) {
    List<Media> list = [];
    for (int i = 0; i < jsonArray['Result'].length; i++) {
      list.add(Media.fromJson(jsonArray['Result'][i]));
    }
    return list;
  }

  static Future<String> getData(pageSize, pageNumber) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL +
        'MediaGalleries/GetMediaGalleryPaging?pageSize=' +
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
  // static Future<String> getData() async {
  //   //dynamic myJson = await rootBundle.loadString('news.json');
  //   //print(myJson);
  //   return await rootBundle.loadString('lib/models/media/media.json');
  //   // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  // }

  @override
  String toString() {
    return 'Media{coverPhoto: $coverPhoto, date: $date, title: $title, description: $description}';
  }
}
