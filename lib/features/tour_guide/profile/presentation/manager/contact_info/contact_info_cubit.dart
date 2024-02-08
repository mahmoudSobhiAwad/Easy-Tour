import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_state.dart';

class ContactInfoCubit extends Cubit<ContactInfoState>{
  ContactInfoCubit({required this.socialLinks,required this.tourGuideProfileRepo}):super(InitialContactInfoSate());
  Map<String,dynamic>socialLinks;
  String initialSocialLink='facebook';
  TextEditingController addTextEditing=TextEditingController();
  bool enableLangDrop=false;
  bool showBottomSheet=false;
  bool isLoading=false;
  String hintText='';
  TourGuideProfileRepo tourGuideProfileRepo;
  Map<String,dynamic>editSocialLinks={};
  FormData formData=FormData();
  void setEditSocialLinks(){
    editSocialLinks.addAll(socialLinks);
    emit(LoadingInitialSocialLinks());
  }
  void addToSocialLinks({required String name,required String link})
  {
    if(name=='whatsapp'){
      hintText='Enter only Your Number';
      editSocialLinks.addAll({name:'https://wa.me/+2$link'});
    }
    else if(name=='facebook'){
      hintText='Enter only Your FaceBook Account Name';
      editSocialLinks.addAll({name:'https://www.facebook.com/$link/'});
    }
    else if(name=='instagram'){
      hintText='Enter only Your Instagram Account Name';
      editSocialLinks.addAll({name:'https://www.instagram.com/$link/'});
    }
    else if(name=='linkedIn'){
      hintText='Enter only Your LinkedIn Account Name';
      editSocialLinks.addAll({name:'https://www.linkedin.com/in/$link/'});
    }
    else if(name=='twitter'){
      hintText='Enter only Your Twitter Account Name';
      editSocialLinks.addAll({name:'https://twitter.com/$link/'});
    }
    else{
      editSocialLinks.addAll({name:link});
    }
    emit(AddLinkToContactInfoSate());
    addTextEditing.clear();
    changeBottomSheet();
  }
  void removeFromSocialLinks({required String name})
  {
    editSocialLinks.remove(name);
    emit(RemoveContactInfoSate());
  }
  void updateAnySocialLink({required String name,required String link})
  {
    if(link.isEmpty){
      removeFromSocialLinks(name: name);
    }
    else{
      editSocialLinks.update(name, (value) => link);
      emit(EditContactInfoSate());
    }
  }
  void changeEnableListDrop(){
    enableLangDrop=!enableLangDrop;
    emit(ChangeEnableDragSocialList());
  }
  void changeBottomSheet(){
    showBottomSheet=!showBottomSheet;
    emit(ChangeShowBottomSheet());
  }
  void completeTextEditing(String value){
    addTextEditing.text=value;
  }
  void changeInitialSocial(String value){
    initialSocialLink=value;
    emit(ChangeInitialSocialValue());
  }
  void updateContactInfo()async{
    FormData formData=FormData.fromMap({
      'contactInfo':editSocialLinks,
    });
    isLoading=true;
    emit(LoadingUpdateContactInfo());
    var result=await tourGuideProfileRepo.updateContactInfo(infoModel:formData);
    result.fold((failure){
      isLoading=false;
      emit(FailureUpdateContactInfo(errMessage:failure.errMessage));
      debugPrint(failure.errMessage);
    }, (contactInfo){
      isLoading=false;
      emit(SuccessUpdateContactInfo());
    });
  }
}
