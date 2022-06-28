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
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ldce_alumni/core/globals.dart' as globals;

class Events {
  //  final String? imageUrl, date, title, venue, time;

  String coverPhoto, startDate, endDate, title, shortDescription, description, venue, contactPerson;
  List<String>? attachmentList;
  Events(this.coverPhoto, this.startDate, this.endDate, this.title, this.shortDescription,
      this.description, this.venue, this.contactPerson, this.attachmentList);

  static Future<List<Events>> getDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getSingleListFromJson(data);
  }

  static List<Events> getSingleListFromJson(Map<String, dynamic> jsonArray) {
    List<Events> list = [];
    for (int i = 0; i < jsonArray["Result"].length; i++) {
      list.add(Events.fromJson(jsonArray["Result"][i]));
    }
    return list;
  }

  static Future<List<Events>> getUpcomingDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    print("_____________________________--");
    print(data);
    return getListFromJson(data).first;
  }

  static Future<List<Events>> getPastDummyList({pageSize = 5, pageNumber = 1}) async {
    dynamic data = json.decode(await getData(pageSize, pageNumber));
    // print("_____________________________--");
    // print(data);
    return getListFromJson(data).last;
  }

  static Future<Events> getOne() async {
    return (await getUpcomingDummyList())[0];
  }

  static Events fromJson(Map<String, dynamic> jsonObject) {
    List<String> attachmentList = [];
    String coverPhoto = jsonObject['CoverPhotoPath'].toString();
    String startDate = jsonObject['StartDate'].toString();
    String endDate = jsonObject['EndDate'].toString();

    String title = jsonObject['Title'].toString();
    String description = jsonObject['HtmlContent'].toString();
    String shortDescription = jsonObject['Description'].toString();
    String venue = jsonObject['Venue'].toString();
    String contactPerson = jsonObject['ContactPerson'].toString();
    for (var i = 0; i < jsonObject['Attachement'].length; i++) {
      print("jsonObject['Attachement'][i]['Path']");
      print(jsonObject['Attachement'][i]['Path']);
      attachmentList.add(jsonObject['Attachement'][i]['Path']);
    }
    return Events(coverPhoto, startDate, endDate, title, shortDescription, description, venue,
        contactPerson, attachmentList);
  }

  static Events getSingleEventFromJson(Map<String, dynamic> jsonArray) {
    print("getSingleNewsFromJson");
    print(jsonArray['Result']['Title']);
    print(jsonArray['Result']['Id']);

    return Events.fromJson(jsonArray["Result"]);
  }

  static Future<String> getDataById(eventsId) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL + 'Events/' + eventsId.toString());

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

  static Future<Events> getOneEvent({eventId}) async {
    dynamic data = json.decode(await getDataById(eventId));
    print("_____________________________--");
    print(data);
    return getSingleEventFromJson(data);
  }

  static Set<List<Events>> getListFromJson(Map<String, dynamic> jsonArray) {
    final now = DateTime.now();

    List<Events> upcomingEventList = [];
    List<Events> pastEventList = [];

    for (int i = 0; i < jsonArray['Result'].length; i++) {
      // print("Start DT :"+ jsonArray[i]['startDate']);
      //2022-02-11T18:00:00
      DateTime dateTime = DateTime.parse(jsonArray["Result"][i]['StartDate']);
      // DateTime dt = DateFormat('y/M/d').parse(jsonArray["Result"][i]['StartDate']);
      // var outputFormat = DateFormat('dd MMM yyyy');
      // var outputDate = outputFormat.format(dateTime);
      if (dateTime.isAfter(now)) {
        upcomingEventList.add(Events.fromJson(jsonArray["Result"][i]));
        print("Upcoming : " + jsonArray["Result"][i]['Title']);
      } else {
        pastEventList.add(Events.fromJson(jsonArray["Result"][i]));
        print("Past : " + jsonArray["Result"][i]['Title']);
      }

      // print(jsonArray[i]['title']);
      // print("DT:");
      // print(dt);
      // if () {

      // } else {
      // }
      // list.add(Event.fromJson(jsonArray[i]));
    }
    //upcomingEventList.sort((startDate,b) => startDate.compareTo(b));

    return {upcomingEventList, pastEventList};
  }

  static Future<String> getData(pageSize, pageNumber) async {
    // dynamic myJson = await rootBundle.loadString('news.json');
    // print(myJson);

    var url = Uri.parse(globals.BASE_API_URL +
        'Events/GetEventPaging?pageSize=' +
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
  //   return await rootBundle.loadString('lib/models/events/events.json');
  //   // /home/evilknight/Desktop/Projects/LD/ld_alumni/lib/models/home/news.json
  // }

  @override
  String toString() {
    return 'Events{imageUrl: $coverPhoto, startdate: $endDate, startdate: $endDate, title: $title,description: $description, venue: $venue, contactPerson: $contactPerson}';
  }
}
