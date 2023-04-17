import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const kQuizContainerFactor = 0.25;
const kPadding = 20.0;
const calendarIcon = "lib/assets/icons/calendar.png";
const speedIcon = "lib/assets/icons/speed.png";
const trophyIcon = "lib/assets/icons/trophy.png";
const userIcon = "lib/assets/icons/user.png";
const rightArrowIcon = "lib/assets/icons/right_arrow.png";

///Circle Values constants
const kSizeHistoryCircle = 120.0;
const kSizeFoodCircle = 60.0;

///Colors
Color kColorPlayNow = const Color(0xFF1340BA);
Color kColorClickQuizButton = const Color(0xFF2BB8EE);
///Lottie Files
const jsonLottieQuiz = "lib/assets/json/quiz.json";
const jsonLottieCorrect = "lib/assets/json/correct.json";
const jsonLottieWrong = "lib/assets/json/wrong.json";


List<Map<String, String>> circles = [
  {"color": "0xFFFEBB16", "title": "History", "size" : "110.0"},
  {"color": "0xFFFC2664", "title": "Food", "size" : "60.0"},
  {"color": "0xFF24E5B7", "title": 'π', "size" : "50.0"},
  {"color": "0xFF37BDF8", "title": 'Culture', "size" : "90.0"},
  {"color": "0xFF392BDE", "title": 'Movies', "size" : "95"},
  {"color": "0xFFF8983C", "title": 'Music', "size" : "65"},
  {"color": "0xFF4AD845", "title": 'Comics', "size" : "140"},
];

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

List<String> quizAnswers = ['Krypton', 'Asgard', 'Azeroth'];
