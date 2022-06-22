/*

 {
            "Id": 31,
            "EncryptedEventId": "pMcGf5SbRO0=",
            "Title": "LDCE@75 Curtain Raiser Event",
            "Description": "LDCE@75 Curtain Raiser Event",
            "HtmlContent": "Join us atLDCE@75 Curtain raiser event...As we move forward on our journey towards Platinum Jubilee Celebrations! Your esteem presence will make this even more special and add to enthusiasm of students, faculty and alumni that are working on LDCE@75 celebrations plans. ",
            "Venue": "Central Plaza (Fondly known as Student Square)",
            "ContactPerson": "Prof Chaitanya Sanghavi",
            "StartDate": "2022-04-01T17:00:00",
            "EndDate": "2022-04-01T17:01:00",
            "CreatedOn": "2022-03-31T07:35:48.07",
            "HasCoverPhoto": true,
            "CoverPhotoPath": "ldcealumni.net/Content/Event/Cover/ldce-75curtainraiser-31032022073548.jpg",
            "Attachement": []
        },

 */
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ld_alumni/core/globals.dart' as globals;

class DigitalDownloads {
  //  final String? imageUrl, date, title, venue, time;

  String title, description, category, fileUrl, pdfFileUrl;
  DigitalDownloads(this.title, this.description, this.category, this.fileUrl, this.pdfFileUrl);

  static Future<List<DigitalDownloads>> getDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getSingleListFromJson(data);
  }

  static List<DigitalDownloads> getSingleListFromJson(Map<String, dynamic> jsonArray) {
    List<DigitalDownloads> list = [];
    for (int i = 0; i < jsonArray["Result"].length; i++) {
      list.add(DigitalDownloads.fromJson(jsonArray["Result"][i]));
    }
    return list;
  }

  static Future<List<DigitalDownloads>> getMobileSkinsList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getMobileSkinData(pageSize, pageNumber));
    print("_____________________________--");
    print(pageNumber);
    return getListFromJson(data);
  }

  static Future<List<DigitalDownloads>> getDesktopWallpaperList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getDesktopWallpapersData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<List<DigitalDownloads>> getCalendarsList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getCalendarsData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<List<DigitalDownloads>> getCampaignDownloadsList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getCampaignDownloadsData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<List<DigitalDownloads>> getOtherMList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getOtherMaterialsData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data);
  }

  static Future<DigitalDownloads> getOne() async {
    return (await getMobileSkinsList())[0];
  }

  static DigitalDownloads fromJson(Map<String, dynamic> jsonObject) {
    String fileUrl = jsonObject['FileName'].toString();
    String pdfFile = jsonObject['PDFFileName'].toString();
    String category = jsonObject['CategoryType'].toString();

    String title = jsonObject['Title'].toString();
    String description = jsonObject['Description'].toString();

    return DigitalDownloads(title, description, category, fileUrl, pdfFile);
  }

  static DigitalDownloads getSingleEventFromJson(Map<String, dynamic> jsonArray) {
    print("getSingleNewsFromJson");
    print(jsonArray['Result']['Title']);
    print(jsonArray['Result']['Id']);

    return DigitalDownloads.fromJson(jsonArray["Result"]);
  }

  static Future<String> getDataById(digitalDldId) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);
// https://ldcealumniapi.devitsandbox.com/api/DigitalDownload/{Id}
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload/' + digitalDldId.toString());

    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getDataById EVENTS : ");
      // print(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<DigitalDownloads> getOneEvent({eventId}) async {
    dynamic data = json.decode(await getDataById(eventId));
    // print("_____________________________--");
    // print(data);
    return getSingleEventFromJson(data);
  }

  static List<DigitalDownloads> getListFromJson(Map<String, dynamic> jsonArray) {
    List<DigitalDownloads> digitalDownloads = [];

    for (int i = 0; i < jsonArray['Result'].length; i++) {
      // print("Start DT :"+ jsonArray[i]['startDate']);
      //2022-02-11T18:00:00

      digitalDownloads.add(DigitalDownloads.fromJson(jsonArray["Result"][i]));

      // print(jsonArray[i]['title']);
      // print("DT:");
      // print(dt);
      // if () {

      // } else {
      // }
      // list.add(Event.fromJson(jsonArray[i]));
    }
    //upcomingEventList.sort((startDate,b) => startDate.compareTo(b));

    return digitalDownloads;
  }

  static Future<String> getData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getMobileSkinData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload?Mobileskin&pageSize='+pageSize.toString()+'&pageNumber='+pageNumber.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getMobileSkinData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getDesktopWallpapersData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload?DesktopWallpaper&pageSize='+pageSize.toString()+'&pageNumber='+pageNumber.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getDesktopWallpapersData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getCalendarsData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload?Calendar&pageSize='+pageSize.toString()+'&pageNumber='+pageNumber.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getCalendarsData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getCampaignDownloadsData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload?CampaignDownload&pageSize='+pageSize.toString()+'&pageNumber='+pageNumber.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getCampaignDownloadsData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }

  static Future<String> getOtherMaterialsData(pageSize, pageNumber) async {
    var url = Uri.parse(globals.BASE_API_URL + 'DigitalDownload?OtherMaterial&pageSize='+pageSize.toString()+'&pageNumber='+pageNumber.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // print("getOtherMaterialsData DD : " + pageNumber.toString());
      // print(response.body);
      // dynamic data = json.decode(response.body);
      // print(data["Status"]);
      return response.body;
    } else {
      return '';
    } // return await rootBundle.loadString('lib/models/news/news.json');
    // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  }
/**
 * 
 * 
 * 
 * List<DigitalDownloads> mobileSkins = [];
    List<DigitalDownloads> desktopWallpapers = [];
    List<DigitalDownloads> calendars = [];
    List<DigitalDownloads> campaignDownloads = [];
    List<DigitalDownloads> otherMaterials = [];
 */
  // static Future<String> getData() async {
  //   //dynamic myJson = await rootBundle.loadString('news.json');
  //   //print(myJson);
  //   return await rootBundle.loadString('lib/models/events/events.json');
  //   // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  // }

  // @override
  // String toString() {
  //   return 'Events{imageUrl: $title, startdate: $category, startdate: $category, title: $title,description: $description, venue: $venue, contactPerson: $contactPerson}';
  // }
}
