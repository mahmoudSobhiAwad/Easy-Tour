import 'package:prepare_project/core/utilities/function/set_app_state.dart';

List<String>signUpTourGuideButton=const ['Next','Next','Sign Up'];
List<String>loginResetPassword=const ['Send','Verify','Update'];
const List<String> genders=<String>['male','female',];
const String kTouristInfoBox='touristInfoBox';
List<String>stepsNamesSignUp=const['Id Verification','Personal Details','Create E-mail'];
List<String>stepsNamesResetPassword=const['Send Email','Otp Code','Reset Password'];
const List<String> languages =<String> [
  "English",
  "Spanish",
  "Mandarin Chinese",
  "Hindi",
  "Arabic",
  "Bengali",
  "Portuguese",
  "Russian",
  "Japanese",
  "Punjabi",
  "German",
  "French",
  "Javanese",
  "Telugu",
  "Marathi",
  "Tamil",
  "Turkish",
  "Urdu",
  "Korean",
  "Italian",
  "Hausa",
  "Dutch",
  "Swahili",
  "Gujarati",
  "Kannada",
  "Odia",
  "Malayalam",
  "Burmese",
  "Thai",
  "Sindhi",
  "Sinhala",
  "Nepali",
  "Kurdish",
  "Tamil",
  "Farsi (Persian)",
  "Malay",
  "Uzbek",
  "Oromo",
  "Maithili",
  "Yoruba",
  "Amharic",
  "Haitian Creole",
  "Armenian",
  "Finnish",
  "Icelandic",
  "Latvian",
  "Lithuanian",
];
List<String> prefs = const [
  "Historical and Cultural Tours",
  "Nile River Cruises",
  "Desert Adventures",
  "Beach and Red Sea Resorts",
  "Adventure and Wildlife Tours",
  "Religious and Pilgrimage Trips",
  "Luxury Tours",
  "Food and Culinary Tours",
  "Family-Friendly Trips",
  "Romantic Getaways",
  "Educational and Study Tours",
  "Special Interest Tours",
];
enum Role{tourist,tourGuide}
const String authTourist='auth/tourist/';
const String authTourGuide='auth/tourGuide/';
const String homeEndPointTourist='home/tourist/';
const String homeEndPointTourGuide='home/tourGuide/';
String homeEndMutualPoint='home/${SetAppState.prefs?.get('role')}/';
const baseUrl='http://54.242.200.234:8081/';
const chatBotUrl='http://34.201.135.1460:8000/chatbot';
const generateTripUrl='http://34.207.118.140:8000/generate_trip';
const scanQrUrl='http://184.72.88.92:8000/decrypt/';
