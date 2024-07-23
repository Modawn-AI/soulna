// import 'dart:math';
//
// import 'package:Soulna/utils/package_exporter.dart';
//
// class LetterListPage extends StatefulWidget {
//   const LetterListPage({super.key});
//
//   @override
//   State<LetterListPage> createState() => _LetterListPageState();
// }
//
// class _LetterListPageState extends State<LetterListPage> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   String getRandomImageIndex() {
//     final random = Random();
//     final videoNumber = random.nextInt(20) + 1;
//     return videoNumber.toString();
//   }
//
//   String getDayFromDate(String date) {
//     return date.split('-')[0];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: ThemeSetting.of(context).primaryBackground,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         scrolledUnderElevation: 0,
//         title: const Text('Letter List Page'),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [],
//         ),
//       ),
//     );
//   }
// }