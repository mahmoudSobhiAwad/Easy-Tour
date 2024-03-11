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
const baseUrl='http://54.157.76.16:8081/';
const chatBotUrl='http://3.88.138.209:8000/chatbot';
const generateTripUrl='http://34.229.1.85:8000/generate_trip';
const scanQrUrl='http://54.144.127.183:8000/decrypt/';
const String defaultCoverTrip='https://th.bing.com/th/id/R.1243dd08863d375493d067c465ba4d11?rik=EeIrjiNEyiabWA&pid=ImgRaw&r=0';