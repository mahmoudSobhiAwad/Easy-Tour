import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/core/utilities/network/dio_consumer.dart';
import 'package:prepare_project/core/utilities/network/end_points.dart';
import 'package:prepare_project/core/utilities/network/interceptor.dart';
import 'package:prepare_project/core/widget/change_passowrd/data/repos/change_password_repo_impl.dart';
import 'package:prepare_project/core/widget/delete_account/data/repos/delete_acc_repo_imp.dart';
import 'package:prepare_project/features/forget_pass/data/repo/forget_pass_repo_imp.dart';
import 'package:prepare_project/features/login/data/repos/login_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/home/data/repo/tour_guide_home_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo_impl.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/book_request_with_guide/request_to_book_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_all_tour_guide_trips_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_guide_info_repo/get_guide_info_repo_imp.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/repo/chat_bot_repo_impl.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/chat_oto/chat_oto_repo_imp.dart';
import 'package:prepare_project/features/tourist/entertainment_places/data/repos/entertainment_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/google_map/data/repo/text_search_repo/text_search_repo_imp.dart';
import 'package:prepare_project/features/tourist/image_classification/data/repos/qr_scanned_repo_imp.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/nearby_places_repo_imp.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/photo_repo/get_photo_repo_imp.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profie_repo_imp.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';
import '../../../features/sign_up/data/repos/sign_up_repo_imp.dart';
import '../../../features/tourist/chat_with_other/data/repos/get_guide_meta_data/get_guide_meta_data_repo_imp.dart';

final getIt=GetIt.instance;
void setUp()
{
getIt.registerSingleton<ApiServices>(ApiServices(dio: Dio()));
getIt.registerSingleton<SignUpRepoImp>(SignUpRepoImp(getIt.get<ApiServices>()));
getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl(getIt.get<ApiServices>()));
getIt.registerSingleton<ForgetPassRepoImpl>(ForgetPassRepoImpl(apiServices: getIt.get<ApiServices>(),));
getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(getIt.get<ApiServices>()));
getIt.registerSingleton<TourGuideProfileRepoImp>(TourGuideProfileRepoImp(apiServices: getIt.get<ApiServices>()));
getIt.registerSingleton<PrivateTourRepoImp>(PrivateTourRepoImp(apiServices: getIt.get<ApiServices>()));
getIt.registerSingleton<HomeTouristRepoImp>(HomeTouristRepoImp(getIt.get<ApiServices>()));
getIt.registerSingleton<HomeTourGuideRepoImp>(HomeTourGuideRepoImp(getIt.get<ApiServices>()));
getIt.registerSingleton<DeleteAccountRepoImpl>(DeleteAccountRepoImpl(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<TourGuideTripsForTouristRepoImp>(TourGuideTripsForTouristRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<ChangePasswordRepoImp>(ChangePasswordRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<GetGuideInfoForTouristRepImp>(GetGuideInfoForTouristRepImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<ChatOTORepoImp>(ChatOTORepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<PhotoOfPlaceRepoImp>(PhotoOfPlaceRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<GoogleSearchRepoImp>(GoogleSearchRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<GetAllRequestedTripRepoImpl>(GetAllRequestedTripRepoImpl(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<RequestToBookTripWithGuideRepoImp>(RequestToBookTripWithGuideRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<ChatBotRepoImp>(ChatBotRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<NearbyPlacesRepoImpl>(NearbyPlacesRepoImpl(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<GuideMetaDataAndChatRecentRepoImp>(GuideMetaDataAndChatRecentRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<GenerateTripRepoImp>(GenerateTripRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<EntertainmentPlaceRepoImp>(EntertainmentPlaceRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<QrScannedRepoImp>(QrScannedRepoImp(apiServices:getIt.get<ApiServices>()));
getIt.registerSingleton<LogInterceptor>(LogInterceptor());

getIt.registerSingleton<DioConsumer>(DioConsumer(
    client: Dio()..
    options.baseUrl = EndPoints.baseUrl
     ..interceptors.add(LogInterceptor())
      ..httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout:const Duration(seconds: 10)),)..interceptors.add(CustomInterceptors(client: Dio()),)
));


}