class OnBoardingModel{
  String imagePath;
  String text;
  OnBoardingModel({required this.imagePath,required this.text,});
}
List<OnBoardingModel>onBoardList=[
  OnBoardingModel(imagePath: onBoardingBath_1, text: 'Let’s Make Your Dream Vacation'),
  OnBoardingModel(imagePath: onBoardingBath_2, text: 'You Can be with Our Special Tour Guide'),
  OnBoardingModel(imagePath: onBoardingBath_3, text: 'Book With Our Tourism Company'),
];
const String onBoardingBath_1='assets/on_boarding_images/on_boarding_1.jpg';
const String onBoardingBath_2='assets/on_boarding_images/on_boarding_2.jpg';
const String onBoardingBath_3='assets/on_boarding_images/on_boarding_3.png';