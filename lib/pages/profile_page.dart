import 'package:Soulna/manager/social_manager.dart';
import 'package:Soulna/utils/package_exporter.dart';
import 'package:Soulna/widgets/twobutton_bottom_widget.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ProfilePage extends StatefulWidget {
  final String? initialId; // 전달받은 id

  const ProfilePage({super.key, this.initialId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with RouteAware {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ThemeSetting.of(context).secondaryBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // context.pushNamed('NotificationPage');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildAccountOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/daily_images/daily_16.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, ThemeSetting.of(context).primaryBackground],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/daily.png'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Andrew D.',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'andrew@domainname.com',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOptions() {
    return Expanded(
      child: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person_outline, color: ThemeSetting.of(context).primaryText),
              title: Text('Edit Profile', style: TextStyle(color: ThemeSetting.of(context).primaryText)),
              trailing: Icon(Icons.chevron_right, color: ThemeSetting.of(context).primaryText),
              onTap: () {
                context.pushNamed('ProfileEditPage');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_none, color: ThemeSetting.of(context).primaryText),
              title: Text('Notification Settings', style: TextStyle(color: ThemeSetting.of(context).primaryText)),
              trailing: Icon(Icons.chevron_right, color: ThemeSetting.of(context).primaryText),
              onTap: () {
                context.pushNamed('NotificationPage');
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline, color: ThemeSetting.of(context).primaryText),
              title: Text('Support', style: TextStyle(color: ThemeSetting.of(context).primaryText)),
              trailing: Icon(Icons.chevron_right, color: ThemeSetting.of(context).primaryText),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: ThemeSetting.of(context).secondaryBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => SafeArea(
                      child: TwoButtonBottomWidget(
                        description: LocaleKeys.common_logout_title.tr(),
                        firstButtonText: LocaleKeys.common_cancel_text.tr(),
                        secondButtonText: LocaleKeys.common_confirm_text.tr(),
                        onFirstButtonPressed: () async {
                          context.pop();
                        },
                        onSecondButtonPressed: () async {
                          // await SocialManager.getInstance().googleLogout(callback: () {});
                          await SocialManager().socialLogout(callback: () {
                            AlertManager().toastMessage(context, LocaleKeys.settings_success_logout_toast.tr(), "success");
                            context.goNamed("initialize");
                          });
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(),
                child: Text(
                  'Log Out',
                  style: ThemeSetting.of(context).bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
