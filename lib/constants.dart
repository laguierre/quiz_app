import 'package:flutter/widgets.dart';

const kQuizContainerFactor = 0.25;
const kPadding = 20.0;
const calendarIcon = "lib/assets/icons/calendar.png";
const speedIcon = "lib/assets/icons/speed.png";
const trophyIcon = "lib/assets/icons/trophy.png";
const userIcon = "lib/assets/icons/user.png";

Map<String, String> userData = {
  "name": "David",
  "surname": "Courtney",
  "email": "davidcourtney@quiz.com",
  "level": "06",
  "points": "3.980",
  "rank": "720"
};

List<Map<String, String>> data = [
  {
    "subtitle": "NEW",
    "title": "Quick Play",
    "icon": "lib/assets/icons/speed.png",
    "color": "0xFFEF9142",
  },
  {
    "subtitle": "JANUARY",
    "title": "Events",
    "icon": "lib/assets/icons/calendar.png",
    "color": "0xFF339C6F1",
  },
  {
    "subtitle": "SEASON 3",
    "title": "Tournament",
    "icon": "lib/assets/icons/trophy.png",
    "color": "0xFFEB376D",
  },
  {
    "subtitle": "PLAY WITH FRIENDS",
    "title": "Rivals",
    "icon": "lib/assets/icons/user.png",
    "color": "0xFF9769E0"
  },
];
