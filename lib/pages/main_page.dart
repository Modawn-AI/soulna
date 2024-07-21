import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/utils/shared_preference.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());
  String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initialDynamicLink(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRouter(BuildContext context, Uri? path) {
    if (path != null) {
      String deeplink = path.toString().replaceAll("", "");
      String routerName = deeplink.split("?")[0];
      if (routerName == "ContentsCreateDetailPage") {
        context.pushNamed("ContentsCreateDetailPage", queryParameters: {
          "contentId": path.queryParameters['contentId'] ?? "",
        });
      }
      if (routerName == "InvitePage") {
        SharedPreferencesManager.setString(key: kInviteUserIdSPKey, value: path.queryParameters['userId'] ?? "");
      }
    }
  }

  Future<void> initialDynamicLink(BuildContext context) async {
    PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      _onRouter(context, data.link);
    }
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      _onRouter(context, event.link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: AppBar(
        title: Text(
          'Dear Me',
          style: ThemeSetting.of(context).headlineLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // context.pushNamed('NotificationPage');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text('Error: $errorMessage'))
                : _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Ready Action!',
                  style: ThemeSetting.of(context).displayMedium,
                ),
                Text(
                  formattedDate,
                  style: ThemeSetting.of(context).headlineLarge,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: constraints.maxWidth / (constraints.maxHeight), // 비율 조정
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey[900],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          '[title]',
                                          style: ThemeSetting.of(context).headlineSmall,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomLeft, // or Alignment.bottomCenter
                                            child: Text(
                                              '[description]',
                                              style: ThemeSetting.of(context).bodyMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Material(
                                  color: ThemeSetting.of(context).primary,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {},
                                    splashColor: Colors.white.withOpacity(0.3),
                                    highlightColor: Colors.white.withOpacity(0.1),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Center(
                                        child: Text(
                                          'Answer Me',
                                          style: ThemeSetting.of(context).bodyLarge.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    text: "Play Today's Letter",
                    icon: const Icon(Icons.play_arrow_rounded),
                    onPressed: () async {},
                    options: CustomButtonOptions(
                      height: 48,
                      textStyle: ThemeSetting.of(context).bodyLarge,
                      color: ThemeSetting.of(context).tertiary,
                      borderSide: BorderSide(
                        color: ThemeSetting.of(context).tertiary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
