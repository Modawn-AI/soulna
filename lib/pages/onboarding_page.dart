import 'package:Soulna/utils/package_exporter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart' as smooth_page_indicator;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var currentPage = 0;
  PageController? tutorialPageViewController;

  @override
  void initState() {
    super.initState();
    tutorialPageViewController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tutorialPageViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeSetting.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: PageView(
                controller: tutorialPageViewController,
                onPageChanged: (count) => setState(() {
                  currentPage = count;
                  debugPrint('currentPage: $currentPage');
                }),
                scrollDirection: Axis.horizontal,
                children: [
                  buildOnboardingPage(
                    context,
                    'assets/images/onboarding_1.png',
                    "Data Security Privacy",
                    "At 'Dear Me,' we prioritize your privacy by securely storing your data on your device with trusted databases like SQLite or Realm, ensuring it remains local. We use data masking, tokenization, and differential privacy to anonymize and protect your identity. When necessary, secure protocols like SSL/TLS and AES encryption safeguard your data during transmission. By minimizing the transfer of personal information and processing most data locally, we ensure your trust and uphold the highest standards of data privacy and security.",
                  ),
                  buildOnboardingPage(
                    context,
                    'assets/images/onboarding_2.png',
                    "Philosophy",
                    "At 'Dear Me,' our core belief is that everyone deserves daily motivation to become their best self. We understand the power of positive reinforcement and the unique impact of hearing encouragement in your own voice. This information should be ONLY kept to yourself as well.",
                  ),
                  buildOnboardingPage(
                    context,
                    'assets/images/onboarding_3.png',
                    "How we make money",
                    "We believe that listening to yourself every day for motivation can significantly enhance your relationships, productivity, and overall well-being. To provide this valuable service while respecting your privacy, we ask for a subscription fee of \$15 USD per month. We don’t have to run ads or sell your data like others to keep our business afloat. This is about 10% of the cost of just 1 hour with a psychiatrist in NYC, making it an affordable option for daily motivation and self-improvement.",
                  ),
                  buildOnboardingPage(
                    context,
                    'assets/images/onboarding_4.png',
                    "3 days Free trial!",
                    "Experience 'Dear Me' risk-free for three days. If it doesn't instantly motivate you, we don't deserve to take your money. Your satisfaction and success are our top priorities. Try it now and see the difference for yourself!",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: smooth_page_indicator.SmoothPageIndicator(
                controller: tutorialPageViewController!,
                count: 4,
                axisDirection: Axis.horizontal,
                onDotClicked: (i) async {
                  await tutorialPageViewController!.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                effect: smooth_page_indicator.ExpandingDotsEffect(
                  expansionFactor: 3.0,
                  spacing: 6.0,
                  radius: 16.0,
                  dotWidth: 6.0,
                  dotHeight: 6.0,
                  dotColor: ThemeSetting.of(context).disabledBackground,
                  activeDotColor: ThemeSetting.of(context).primaryText,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      onPressed: () async {
                        if (currentPage == 3) {
                          context.pushNamed('LoginPage');
                        } else {
                          await tutorialPageViewController?.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      text: LocaleKeys.common_confirm_text.tr(),
                      options: CustomButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: ThemeSetting.of(context).primary,
                        textStyle: ThemeSetting.of(context).labelLarge.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: ThemeSetting.of(context).primaryText,
                            ),
                        elevation: 0.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      showLoadingIndicator: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnboardingPage(BuildContext context, String imagePath, String title, String description) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 300.0,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: ThemeSetting.of(context).displaySmall,
                    ),
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: ThemeSetting.of(context).bodyMedium.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: ThemeSetting.of(context).primaryText,
                          lineHeight: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
