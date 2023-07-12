import 'package:apna_khata/Authentication/welcome.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

bool isLastPage = false;
int _currentPage = 0;
final _controller = PageController(
  initialPage: 0,
);
List<Widget> _pages = [
  Column(
    children: [
      SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Expanded(
          child: Image.asset(
            "assets/acc.jpg",
          ),
        ),
      ),
      SizedBox(
        height: 24,
      ),
      const Text(
        "Create new customers",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          "In order to make your business world wide , make sure you make new customers and make them comfortable with your accounting systems.",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ),
  Column(
    children: [
      Expanded(
        child: Image.asset(
          "assets/acc1.jpg",
        ),
      ),
      const Text(
        "Create the customer Account",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 2),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          "Make sure you make every entry more carefully to avoid any human error in your accounts",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ),
  Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Expanded(
            child: Image.asset(
              "assets/acc3.jpg",
            ),
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      const Text(
        "Trust is everything in business",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          "Become tension free about accounting books and all other relative heavy things , All data will be in mobile .",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  ),
];

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      // backgroundColor: const Color(0XFFF3F3F3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    isLastPage = _currentPage == _pages.length - 1;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            DotsIndicator(
              dotsCount: _pages.length,
              position: _currentPage.toDouble(),
              decorator: const DotsDecorator(
                color: Color(0xffdadada), // Inactive color
                activeColor: Color(0xffC700FF),
              ),
            ),
            isLastPage
                ? const SizedBox(
                    height: 0,
                  )
                : const SizedBox(height: 80),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Skip',
            //         style: TextStyle(color: Colors.purple),
            //       ),
            //     ),
            //     Container(
            //       child: isLastPage
            //           ? Container(
            //         height: 45,
            //         child: FloatingActionButton(
            //           elevation: 5,
            //           backgroundColor: Colors.purple,
            //           child: Icon(
            //             Icons.arrow_forward,
            //             color: Colors.white,
            //             size: 25,
            //           ),
            //           onPressed: () {
            //             // Navigator.pushReplacement(
            //             //     context,
            //             //     MaterialPageRoute(
            //             //       builder: (context) => WelcomeScreen(),
            //             //     ));
            //           },
            //         ),
            //       )
            //           : Container(),
            //     ),
            //   ],
            // ),
            isLastPage
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelomeScreen()),
                      );
                      // MaterialPageRoute(
                      //     builder: (BuildContext context) => RegistrationScreen());
                      // Navigator.pushNamed(context, '/second');
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 60, right: 60, top: 30),
                      alignment: Alignment.center,
                      height: 50,
                      //  padding: EdgeInsets.only(left: 70, right: 70,),
                      decoration: BoxDecoration(
                        // gradient: const LinearGradient(
                        //   colors: [(Color(0xFFFFE259)), (Color(0xFFFFA751))],
                        // ),
                        color: Color(0xffC700FF),
                        borderRadius: BorderRadius.circular(10),
                        // boxShadow: [
                        //   BoxShadow(
                        //     offset: Offset(0, 0),
                        //     blurRadius: 0,
                        //   )
                        // ],
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
