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
                      MdiIcons.google,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms, colors: [
                          Colors.white60,
                          const Color(0xfff73c01),
                          const Color(0xfff7bb0a),
                          const Color(0xff4aaa4d),
                          const Color(0xff1772cb),
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
                    'SECURED BACKUP',
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
                    'Keep your files in closed safe so you can\'t lose them. Consider TrueNAS.',
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
                      MdiIcons.twitter,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                            duration: 2000.ms, color: const Color(0xFF80DDFF))
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
                    'SECURED BACKUP',
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
                    'Keep your files in closed safe so you can\'t lose them. Consider TrueNAS.',
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
                      MdiIcons.facebook,
                      color: Colors.white60,
                      size: constraint.biggest.width -
                          (constraint.biggest.width * 0.2),
                      semanticLabel: 'Text to announce in accessibility modes',
                    );

                    icon = icon
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                        duration: 2000.ms, color: const Color(0xFF176bff))
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
                    'SECURED BACKUP',
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
                    'Keep your files in closed safe so you can\'t lose them. Consider TrueNAS.',
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
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
      debugShowCheckedModeBanner: false,
      title: 'Welcome To Thrill Fit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
