import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onboarding/onboarding.dart';
import 'package:thrill_fit/screens/authentication/login_register_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: LayoutBuilder(builder: (context, constraint) {
                    Widget icon = Icon(
                      MdiIcons.dumbbell,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms, color: Colors.black)
                        .animate() // this wraps the previous Animate in another Animate
                        .fadeIn(duration: 2000.ms, curve: Curves.easeOutQuad)
                        .slide();

                    return icon;
                  })),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'THRILL FIT',
                    style: pageTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome to THRILL FIT, your ultimate fitness companion designed to help you reach your body goals effectively. Whether you\'re aiming to build muscle, lose weight, or enhance your overall fitness, our app makes it simple and enjoyable.',
                    style: pageInfoStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: LayoutBuilder(builder: (context, constraint) {
                    Widget icon = Icon(
                      MdiIcons.weightLifter,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms, colors: [
                          Colors.white60,
                          Colors.black,
                          Colors.white60
                        ])
                        .animate() // this wraps the previous Animate in another Animate
                        .fadeIn(duration: 2000.ms, curve: Curves.easeInOut)
                        .slide();

                    return icon;
                  })),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'WORKOUT PLANS',
                    style: pageTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Say goodbye to generic workout routines! With THRILL FIT, you can easily create personalized workout plans tailored to your specific goals and fitness level. Whether you\'re a beginner or a seasoned gym-goer, our app provides you with expert guidance every step of the way.',
                    style: pageInfoStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(
          color: background,
          border: Border.all(
            width: 0.0,
            color: background,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: LayoutBuilder(builder: (context, constraint) {
                    Widget icon = Icon(
                      MdiIcons.gymnastics,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms, color: Colors.black)
                        .animate() // this wraps the previous Animate in another Animate
                        .fadeIn(duration: 2000.ms, curve: Curves.easeOutQuad)
                        .slide();

                    return icon;
                  })),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'COMMUNITY',
                    style: pageTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Join our vibrant community of fitness enthusiasts on the Feeds page! Here, you can share your workout activities, milestones, and progress photos with fellow users. But that\'s not all – you can also inspire others by sharing the workout plans you\'ve created and the results you\'ve achieved.',
                    style: pageInfoStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = skipButton();
    index = 0;
  }

  Material skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material signupButton(BuildContext context) {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Login/Register',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme(backgroundColor: background)),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme(backgroundColor: background)),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                border: Border.all(
                  width: 0.0,
                  color: background,
                ),
              ),
              child: ColoredBox(
                color: background,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.polygon(
                            polygonDesign: PolygonDesign(
                                polygon: DesignType.polygon_circle),
                          ),
                        ),
                      ),
                      index == pagesLength - 1
                          ? signupButton(context)
                          : skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
