import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ytyt/features/home/services/api_services.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/notes/note_service/note_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (BuildContext context) =>
                    HomeBloc(service: APIService.instance),
              ),
              BlocProvider<VideoListBloc>(
                create: (BuildContext context) =>
                    VideoListBloc(service: APIService.instance),
              ),
              BlocProvider<NoteBloc>(
                create: (BuildContext context) =>
                    NoteBloc(noteDataBaseService: NoteDataBaseService()),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // TRY THIS: Try running your application with "flutter run". You'll see
                // the application has a blue toolbar. Then, without quitting the app,
                // try changing the seedColor in the colorScheme below to Colors.green
                // and then invoke "hot reload" (save your changes or press the "hot
                // reload" button in a Flutter-supported IDE, or press "r" if you used
                // the command line to start the app).
                //
                // Notice that the counter didn't reset back to zero; the application
                // state is not lost during the reload. To reset the state, use hot
                // restart instead.
                //
                // This works for code too, not just values: Most code changes can be
                // tested with just a hot reload.
                colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00000)),
                //    useMaterial3: true,
              ),
              home: const HomeScreenSilver(),
            ),
          );
        });
  }
}
