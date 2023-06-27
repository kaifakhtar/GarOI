// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentPage = 0;
//   PageController _pageController = PageController(initialPage: 0);

//   final List<Widget> _pages = [
//     const OnboardingPage(
//       title: 'Welcome to MyApp',
//       description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//      // imagePath: 'assets/images/page1.png',
//     ),
//     const OnboardingPage(
//       title: 'Explore',
//       description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
// //imagePath: 'assets/images/page2.png',
//     ),
//     const OnboardingPage(
//       title: 'Get Started',
//       description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//     //  imagePath: 'assets/images/page3.png',
//     ),
//   ];

//   double _pageOffset = 0.0;

//   @override
//   void initState() {
//     _pageController.addListener(() {
//   setState(() {
//     _currentPage = _pageController.page!.round();
//     _pageOffset = _pageController.page!;
//   });
// });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: _pages.length,
//             itemBuilder: (BuildContext context, int index) {
//               final double relativePosition = index - _pageOffset;

//               // Calculate the opacity based on the relative position
//              final double opacity = (1 - (relativePosition.abs() ).clamp(0.0, 1.0));


//               // Calculate the translateY based on the relative position
//               final double translateY =
//                   relativePosition * MediaQuery.of(context).size.height;

//               return Transform.translate(
//                 offset: Offset(0.0, translateY),
//                 child: Opacity(
//                   opacity: opacity,
//                   child: _pages[index % _pages.length],
//                 ),
//               );
//             },
//           ),
//             Positioned(
//             bottom: 20.0,
//             left: 0.0,
//             right: 0.0,
//             child: _currentPage == _pages.length - 1
//                 ? _buildGetStartedButton()
//                 : _buildPageIndicator(),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildPageIndicator() {
//     List<Widget> indicators = [];
//     for (int i = 0; i < _pages.length; i++) {
//       indicators.add(
//         i == _currentPage
//             ? _indicator(true)
//             : _indicator(false),
//       );
//     }
//     return indicators;
//   }
//     Widget _buildGetStartedButton() {
//     return ElevatedButton(
//       onPressed: () {
//         // Handle the "Get Started" button click
//       },
//       child: Text('Get Started'),
//     );
//   }


//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       height: 8,
//       width: isActive ? 42 : 16,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.black : Colors.grey,
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }
  
// }

// class OnboardingPage extends StatelessWidget {
//   final String title;
//   final String description;
//   //final String imagePath;

//   const OnboardingPage({
//     required this.title,
//     required this.description,
//    // required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             description,
//             style: const TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 32),
//           // Image.asset(
//           //   imagePath,
//           //   height: 200,
//           //   width: 200,
//           // ),
//         ],
//       ),
//     );
//   }
// }
