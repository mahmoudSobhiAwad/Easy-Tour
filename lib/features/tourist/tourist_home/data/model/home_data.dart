import 'package:prepare_project/features/tourist/tourist_home/data/model/card_model.dart';

List<CardModel>bookingItems=[
  CardModel(imagePath: 'assets/login/tour_guide.png', labelName: 'Tour Guides'),
  CardModel(imagePath: 'assets/tourist_home/hotels.png', labelName: 'Hotel '),
  CardModel(imagePath: 'assets/tourist_home/plane_ticket.png', labelName: 'Plane Tickets'),
  CardModel(imagePath: 'assets/tourist_home/book_cars.png', labelName: 'Book A Car'),
];

List<CardModel>getATripItems= [
  CardModel(imagePath: 'assets/tourist_home/travel_company.png', labelName: 'Generate A Trip'),
  CardModel(imagePath: 'assets/login/tour_guide.png', labelName: 'Tour Guides'),
  CardModel(imagePath: 'assets/tourist_home/custom_trip.png', labelName: 'Make Custom Trip'),
];

List<CardModel>getHelperItems= [
  CardModel(imagePath: 'assets/tourist_home/hotels.png', labelName: 'Hotel '),
  CardModel(imagePath: 'assets/tourist_home/plane_ticket.png', labelName: 'Plane Tickets'),
  CardModel(imagePath: 'assets/tourist_home/Vector_Robot_3.webp', labelName: 'Chat Bot'),
  CardModel(imagePath: 'assets/tourist_home/detect_camera.png', labelName: 'Image Identifier'),
  CardModel(imagePath: 'assets/tourist_home/book_cars.png', labelName: 'Book A Car'),
  CardModel(imagePath: 'assets/tourist_home/weather_forecast.png', labelName: 'Weather Forecasting'),
  CardModel(imagePath: 'assets/tourist_home/currency_exchage.png', labelName: 'Currency Converter'),
];

List<CardModel>placesItem=[
  CardModel(imagePath:'assets/on_boarding_images/on_boarding_1.jpg', labelName: 'Historical Places'),
  CardModel(imagePath:'assets/on_boarding_images/on_boarding_2.jpg' , labelName: 'Entertainment Places '),
];
List<CardModel>aiTool=[
  CardModel(imagePath: 'assets/tourist_home/Vector_Robot_3.webp', labelName: 'Chat Bot'),
  CardModel(imagePath: 'assets/tourist_home/detect_camera.png', labelName: 'Image Identifier'),
  CardModel(imagePath: 'assets/tourist_home/travel_company.png', labelName: 'Generate A Trip'),
];
List<CardModel>helperTool=[
  CardModel(imagePath: 'assets/tourist_home/custom_trip.png', labelName: 'Make Custom Trip'),
  CardModel(imagePath: 'assets/tourist_home/weather_forecast.png', labelName: 'Weather Forecasting'),
  CardModel(imagePath: 'assets/tourist_home/currency_exchage.png', labelName: 'Currency Converter'),
];
List<CardModel>entertainmentItems=[
  CardModel(imagePath: 'assets/entertainment_places/food.png', labelName: 'Restaurants',endPoint: 'restaurant'),
  CardModel(imagePath: 'assets/entertainment_places/museum.png', labelName: 'Museums',endPoint: 'museum'),
  CardModel(imagePath: 'assets/entertainment_places/beach_places.png', labelName: 'Beaches&sea',endPoint: 'museum'),
  CardModel(imagePath: 'assets/entertainment_places/cinema.png', labelName: 'Cinemas',endPoint: 'cinema'),
  CardModel(imagePath: 'assets/entertainment_places/travel.png', labelName: 'Medical Place',endPoint: 'medical'),
  CardModel(imagePath: 'assets/entertainment_places/bazar.png', labelName: 'Bazaars',endPoint: 'bazar'),
];
