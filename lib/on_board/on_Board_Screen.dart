import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String subtitle;

  BoardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnBoardScreen extends StatefulWidget {
  OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var boardController = PageController();
  bool islist = false;

  void submit(){
    Cache.saveData(key: 'onBoarding', value: true).then((saved) {
      if (saved) {
        navigateAndFinsh(context, LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF406be1)),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF406be1), // اللون العلوي
              Color(0xFF527bec), // اللون السفلي (غيره لأي لون تريده)
            ],
            stops: [0.2, 0.5], // يفصل بالضبط في النصف
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boardingData.length - 1) {
                      setState(() {
                        islist = true;
                      });

                    } else {
                      setState(() {
                        islist = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemCount: boardingData.length,
                  itemBuilder: (context, index) {
                    final boarding = boardingData[index];
                    return buildBordingItem(
                      image: boarding.image,
                      titile: boarding.title,
                      subtitle: boarding.subtitle,
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        submit();
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: SmoothPageIndicator(
                      controller: boardController, // PageController
                      count: boardingData.length,
                      effect: SlideEffect(
                        spacing: 30.0,
                        dotColor: Color(0xFF809ff6),
                        activeDotColor: Colors.white,
                      ), // your preferred effect
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if(islist==true){
                          submit();
                        }
                        boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastEaseInToSlowEaseOut,
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBordingItem({
    required String image,
    required String titile,
    required String subtitle,
  }) => Column(
    children: [
      Expanded(child: Image(image: AssetImage(image), height: 550)),
      Text(
        titile,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 20),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ],
  );

  final List<BoardingModel> boardingData = [
    BoardingModel(
      image: 'images/assets/image/Layer 1.png',
      title: 'VISIT OUR\nONLINE SHOP',
      subtitle:
          'We have millions of one-of-a-kind items, so you can find\nwhatever you need for you or anyone you love.',
    ),
    BoardingModel(
      image: 'images/assets/image/Layer 2.png',
      title: 'CHOOSE WHAT\nYOU WANT',
      subtitle:
          'Buy directly from our sellers who put their heart and soul\ninto making something special ',
    ),
    BoardingModel(
      image: 'images/assets/image/Layer 3.png',
      title: 'PLACE OUR\n ORDER',
      subtitle:
          'We use the best-in-class technology to protect any of your\n transaction on our website',
    ),
  ];
}
