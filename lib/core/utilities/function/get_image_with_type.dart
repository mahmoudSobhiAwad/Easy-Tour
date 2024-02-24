import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';

String getImageFromType(String typeImage){
  switch(typeImage){
    case 'Ancient Egyptian Site':return ancientEgyptianSite;
    case 'Museums and Cultural Center':return museumsAndCulturalCenter;
    case 'Beaches and water bodies':return beachesAndWaterBodies;
    case 'Safari and adventures':return safariAndAdventures;
    case 'Historical and Architectural Landmark':return historicalAndArchitecturalLandmark;
    case 'Islamic Site':return islamicSite;
    case 'Christian Site':return christianSite;
    case 'Natural landmarks':return naturalLandmarks;
    default:return'';
  }

}