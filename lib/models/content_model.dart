class UnbordingContent{
  String image;
  String title;
  String discription;

  UnbordingContent({
    required this.image, 
    required this.title, 
    required this.discription
    });
 
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Easy, Fast & Trusted',
    image: 'assets/images/bart_impulsivity.jpg',
    discription: 'Fast money transfer and gauranteed safe transactions with others.',
  ),

  UnbordingContent(
    title: 'Free Transactions',
    image: 'assets/images/vacation_rental5.png',
    discription: 'Provides the quality of the financial system with free money transactions without any fees.',
  ),

  UnbordingContent(
    title: 'Bills Payment Made Easy',
    image: 'assets/images/10075633.jpg',
    discription: 'Pay monthly of daily bills at home in a site of TransferMe.',
  ),
];