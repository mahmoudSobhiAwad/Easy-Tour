import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';

String getImageFromType(String typeImage){
  switch(typeImage){
    case 'Ancient Egyptian Sites':return ancientEgyptianSite;
    case 'Museums And Cultural Centers':return museumsAndCulturalCenter;
    case 'Beaches And Water Bodies':return beachesAndWaterBodies;
    case 'Safari and adventures':return safariAndAdventures;
    case 'Historical and Architectural Landmark':return historicalAndArchitecturalLandmark;
    case 'Islamic Sites':return islamicSite;
    case 'Christian Site':return christianSite;
    case 'Natural Landmarks':return naturalLandmarks;
    case 'Game And Entertainment Centers':return entertainmentPlaces;
    default:return'';
  }

}