import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ytyt/colors/app_colors.dart';
import 'package:ytyt/features/auth/cubit/auth_cubit.dart';
import 'package:ytyt/features/auth/view/screens/login_screen.dart';
import 'package:ytyt/features/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:ytyt/features/home/services/api_services.dart';
import 'package:ytyt/features/home/views/screens/home_screen_silver.dart';
import 'package:ytyt/features/notes/bloc/note_bloc.dart';
import 'package:ytyt/features/video_list.dart/bloc/video_list_bloc.dart';

import 'features/auth/view/screens/signup_screen.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/notes/note_service/note_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/onboarding/onboarding_screen.dart';
import 'routes/routes_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _approuter = AppRouter();
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
              BlocProvider<AuthCubit>(
                create: (BuildContext context) =>
                    AuthCubit(FirebaseAuth.instance),
              ),
            ],
            child: MaterialApp.router(
              routerConfig: _approuter.config(),
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
                colorScheme: ColorScheme.fromSeed(
                    primary: AppColors.gold,
                    secondary: Colors.black,
                    seedColor: const Color.fromARGB(255, 0, 0, 0)),
                //    useMaterial3: true,
              ),
              // home: const LoginScreen(),
            ),
          );
        });
  }
}
