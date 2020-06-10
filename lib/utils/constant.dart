// ROUTES
import 'package:flutter/foundation.dart';

const String route_home = "ROUTEHOME";
const String route_login = "ROUTELOGIN";
const String route_scan = "ROUTESCAN";
const String route_detail = "ROUTEDETAIL";
const String route_profile = "ROUTEPROFILE";

// SAMPLE DATA
const String value1 = "Rumah Terbuka Sempena Sambutan Hari Raya";
const String value2 = "09:00 PM, Sabtu - 30 / 05 / 2020";
const String value3 = "Kolej Melati";
const String value4 =
    "Makanan akan disediakan dan sila datang awal untuk agihan makanan";

const List<Map<String,String>> newEvents = [{
  'event':'Melati Tautan Kasih 2020',
  'venue':'Dewan Platinum Melati',
  'date':'08:00 PM, Wednesday - 26 / 02 / 2020',
  'description':'Kolej Melati introduction session for New student (Penerapan & MDS)'
},{
  'event':'Neon Colour Run 2020',
  'venue':'Pagar Utama Kolej Melati',
  'date':'08:00 PM, Friday - 06 / 03 / 2020',
  'description':'Recreation with Kolej Melati students, College Resident Staff and Kolej Melati Management.'
},{
  'event':'E-Mart Opening',
  'venue':'Next to Bilik Bacaan Blok 3, Aras 1, Kolej Melati',
  'date':'06:30 PM, Sunday - 15 / 03 / 2020',
  'description':'The official opening of the E-Mart under the Kolej Melati Student Entrepreneurship Program. Various of food, snack, drink and clothing available'
},];

const List<Map<String,String>> attemptEvents = [{
  'event':'Karnival Melati Xtra Gegar',
  'venue':'Dewan Platinum Melati',
  'date':'09:00 AM, Friday - 20 / 03 / 2020',
  'description':'Open to all UiTM community! Variety of sales, games, invitation artists and more! '
},{
  'event':'You’re Someones Type',
  'venue':'Pagar Utama Kolej Melati',
  'date':'08:00 PM, Friday - 03 / 04 / 2020',
  'description':"It's blood donation time! What's your type?O, A, B, AB or C? Do you think you could be someone's type? Yes‼ You can ! With your blood it can help to save others"
},];

const List<Map<String,String>> attendedEvents = [{
  'event':'Program ‘Hijrah itu Move on’',
  'venue':'Dewan Platinum Melati',
  'date':'08:00 AM, Sunday - 05 / 04 / 2020',
  'description':'With a special appearance by Ustaz Nabil Ahmad, JAKIM Putrajaya Officer.'
},{
  'event':'A meaning to life ',
  'venue':'Pagar Utama Kolej Melati',
  'date':'08:00 PM, Friday - 10 / 04 / 2020',
  'description':'A night with a cancer survivors'
},];

final List<User> users = [
  User(name: 'Nella Drew', id: '2020333222', ic: '980606125132', semester: '3', course: 'AS299', phone: '0195552322', room: '3B-01-04'),
  User(name: 'Hanis Farisha', id: '2017899233', ic: '970129126280', semester: '6', course: 'LW199', phone: '0148996721', room: '4B-04-10'),
  User(name: 'Mardhiah Ismail', id: '2018200800', ic: '970713135050', semester: '6', course: 'CS244', phone: '0109457889', room: '4B-07-23'),
  User(name: 'Ainna Nida Zainal', id: '2018999111', ic: '970403055670', semester: '5', course: 'CS243', phone: '0138771076', room: '4A-01-09'),
  User(name: 'Suhaiza Saazihan', id: '2018444555', ic: '970530087890', semester: '4', course: 'AP243', phone: '0128873773', room: '3A-02-02'),
  User(name: 'Noorsakinah Kamal', id: '2018333444', ic: '960826046180', semester: '6', course: 'CS244', phone: '0134567788', room: '4B-09-01'),
];

enum InvitationType {
  non,
  attend,
  not,
  attended,
}

class Invitation {
  final String name;
  final String venue;
  final String description;
  final String date;
  final InvitationType type;

  Invitation(this.name, this.date, this.venue, this.description, {this.type = InvitationType.non});
}

class User {
  final String name;
  final String id;
  final String ic;
  final String semester;
  final String course;
  final String phone;
  final String room;

  User({
    @required this.name,
    @required this.id,
    @required this.ic,
    @required this.semester,
    @required this.course,
    @required this.phone,
    @required this.room,
  });

  User.from(User value, String name, String semester, String course,
      String phone, String room)
      : this.name = value.name,
        this.id = value.id,
        this.ic = value.ic,
        this.semester = semester,
        this.course = course,
        this.phone = phone,
        this.room = room;
}
