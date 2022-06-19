
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_task/provider/character_details_provoders/series_provider.dart';
import 'package:marvel_task/provider/character_details_provoders/stories_provider.dart';
import 'package:marvel_task/provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../presentation/routes_manager.dart';
import '../presentation/theme_manager.dart';
import '../provider/character_details_provoders/comics_provider.dart';
import '../provider/character_details_provoders/events_provider.dart';
import '../provider/character_provider.dart';



final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {

  MyApp._internal(); //private name constractor

  static final MyApp  instance = MyApp._internal(); // single instance

  factory MyApp()=>instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
     builder: (ctx,_) =>
      MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CharacterProvider()),
        ChangeNotifierProvider.value(value: ComicsProvider()),
        ChangeNotifierProvider.value(value: EventsProvider()),
        ChangeNotifierProvider.value(value: SeriesProvider()),
        ChangeNotifierProvider.value(value: StoriesProvider()),
        ChangeNotifierProvider.value(value: SearchProvider()),
      ],
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.characterScreen,
        ),
     ),
      
    );
  }
} 