import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_college/Cubits/Auth/Login/GoogleViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/forget_passViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/loginScreenViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/re-passViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/send_codeViewModel.dart';
import 'package:smart_college/Cubits/Home/GetNotificationViewModel.dart';
import 'package:smart_college/Cubits/Home/NotificationDetailsViewModel.dart';
import 'package:smart_college/Cubits/Home/NotificationViewModel.dart';
import 'package:smart_college/Cubits/OpenAI/OpenAIChatCubit.dart';
import 'package:smart_college/Repositories/ChangePasswordRepository.dart';
import 'package:smart_college/Repositories/ChatRepository.dart';
import 'package:smart_college/Repositories/ExamsRepository.dart';  
import 'package:smart_college/Repositories/GoogleRepository.dart';
import 'package:smart_college/Repositories/NotificationDetailsRepository.dart';
import 'package:smart_college/Repositories/NotificationRepository.dart';
import 'package:smart_college/Repositories/ProfileRepository.dart';
import 'package:smart_college/Repositories/ResetPasswordRepository.dart';
import 'package:smart_college/Repositories/SendEmailRepository.dart';
import 'package:smart_college/Repositories/TemplateRepository.dart';
import 'package:smart_college/Repositories/VerifyEmailRepository.dart';
import 'package:smart_college/View/Auth/Login/forget_pass.dart';
import 'package:smart_college/View/Auth/Register/alumniRegister.dart';
import 'package:smart_college/View/Auth/Register/studentRegister.dart';
import 'package:smart_college/View/Graduated/home/dashboard.dart';
import 'package:smart_college/View/Graduated/home/graduatedHomeScreen.dart';
import 'package:smart_college/View/Graduated/home/postgraduat_%20studies.dart';
import 'package:smart_college/View/Graduated/home/training.dart';
import 'package:smart_college/View/Onboarding/onboarding.dart';
import 'package:smart_college/View/Student/Materials&Exams/ExamScreen.dart';
import 'package:smart_college/View/Student/Materials&Exams/ResultScreen.dart';
import 'package:smart_college/View/Student/Profile/ProfileScreen.dart';
import 'package:smart_college/View/Student/studentHomeScreen.dart';
import 'package:smart_college/View/Student/subjects.dart';
import 'package:smart_college/View/home/OpenAIChat/chat.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/services/local/Hive.dart';
import 'package:smart_college/services/remote/apiManager.dart';
import 'package:smart_college/sources/AlumniRegisterDataSource.dart';
import 'package:smart_college/sources/ChangePasswordDataSource.dart';
import 'package:smart_college/sources/ChatDataSource.dart';
import 'package:smart_college/sources/CounterDataSource.dart';
import 'package:smart_college/sources/ExamsDataSource.dart';
import 'package:smart_college/sources/GoogleDataSource.dart';
import 'package:smart_college/sources/LoginDataSource.dart';
import 'package:smart_college/sources/NotificationDataSource.dart';
import 'package:smart_college/sources/NotificationDetailsDataSource.dart';
import 'package:smart_college/sources/ProfileDataSource.dart';
import 'package:smart_college/sources/ResetPasswordDataSource.dart';
import 'package:smart_college/sources/SendEmailDataSource.dart';
import 'package:smart_college/sources/StudentRegisterDataSource.dart';
import 'package:smart_college/sources/VerifyEmailDataSource.dart';
import 'package:smart_college/sources/NewsDataSource.dart';
import 'package:smart_college/sources/LectureDataSource.dart';
import 'package:smart_college/sources/getNotificationDataSource.dart';
import 'package:smart_college/sources/TemplateDataSource.dart';
import 'package:smart_college/utils/colors.dart';
import 'Cubits/Auth/Register/AlumniRegisterViewModel.dart';
import 'Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import 'Cubits/Auth/Register/VerifyemailViewModel.dart';
import 'Cubits/News/NewsCubit.dart';
import 'Cubits/lectures/LectureCubit.dart';
import 'Cubits/Templates/TemplateCubit.dart';
import 'Repositories/AlumniRegisterRepository.dart';
import 'Repositories/CounterRepository.dart';
import 'Repositories/GetNotificationRepository.dart';
import 'Repositories/LoginRepository.dart';
import 'Repositories/StudentRegisterRepository.dart';
import 'Repositories/NewsRepository.dart';
import 'Repositories/LectureRepositort.dart';
import 'Repositories/OpenAIChatRepository.dart';
import 'sources/OpenAIChatDataSource.dart';
import 'View/Auth/Login/login.dart';
import 'View/Splash/SplashScreen.dart';
import 'View/home/accountType.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());

  // افتحي بوكس للرسائل
  await Hive.openBox('messages');

  final apiManager = ApiManager();
  
  // Student & Alumni repositories
  final studentRemoteDataSource = StudentRemoteDataSource(apiManager);
  final studentRepository = StudentRepository(studentRemoteDataSource);

  final alumniRemoteDataSource = AlumniRemoteDataSource(apiManager);
  final alumniRepository = AlumniRepository(alumniRemoteDataSource);

  // Auth repositories
  final verifyEmailRemoteDataSource = VerifyEmailRemoteDataSource(apiManager);
  final verifyEmail = VerifyEmailRepository(verifyEmailRemoteDataSource);

  final loginRemoteDataSource = LoginRemoteDataSource(apiManager);
  final loginRepository = LoginRepository(loginRemoteDataSource);

  final sendEmailRemoteDataSource = SendEmailRemoteDataSource(apiManager);
  final sendEmail = SendEmailRepository(sendEmailRemoteDataSource);

  final resetPasswordRemoteDataSource = ResetPasswordRemoteDataSource(apiManager);
  final sendCode = ResetPasswordRepository(resetPasswordRemoteDataSource);

  final changePassRemoteDataSource = ChangePassRemoteDataSource(apiManager);
  final changePass = ChangePasswordRepository(changePassRemoteDataSource);

  final googleDataSource = GoogleDataSource(apiManager);
  final google = GoogleRepository(googleDataSource);

  // Content repositories
  final newsRemoteDataSource = NewsRemoteDataSource(apiManager);
  final newsRepository = NewsRepository(newsRemoteDataSource);

  final lectureRemoteDataSource = LectureRemoteDataSource(apiManager: apiManager);
  final lectureRepository = LectureRepository(remoteDataSource: lectureRemoteDataSource);

  final templateRemoteDataSource = TemplateRemoteDataSource(apiManager);
  final templateRepository = TemplateRepository(templateRemoteDataSource);
  
  final openAIChatDataSource = OpenAIChatRemoteDataSource(apiManager);
  final openAIChatRepository = OpenAIChatRepository(openAIChatDataSource);

  // ✅ Notification repositories (FIXED - Added missing repositories)
  final notificationDataSource = NotificationRemoteDataSource(apiManager);
  final notificationRepository = NotificationRepository(notificationDataSource);

  final getNotificationDataSource = GetNotificationRemoteDataSource(apiManager);
  final getNotificationRepository = GetNotificationRepository(getNotificationDataSource);

  final notificationDetailsDataSource = NotificationDetailsRemoteDataSource(apiManager);
  final notificationDetailsRepository = NotificationDetailsRepository(notificationDetailsDataSource);

  final counterDataSource = CounterRemoteDataSource(apiManager);
  final counterRepository = CounterRepository(counterDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GoogleRepository>(
          create: (context) => google,
        ),
        RepositoryProvider<StudentRepository>(
          create: (context) => studentRepository,
        ),
        RepositoryProvider<AlumniRepository>(
          create: (context) => alumniRepository,
        ),
        RepositoryProvider<VerifyEmailRepository>(
          create: (context) => verifyEmail,
        ),
        RepositoryProvider<LoginRepository>(
          create: (context) => loginRepository,
        ),
        RepositoryProvider<SendEmailRepository>(
          create: (context) => sendEmail,
        ),
        RepositoryProvider<ResetPasswordRepository>(
          create: (context) => sendCode,
        ),
        RepositoryProvider<ChangePasswordRepository>(
          create: (context) => changePass,
        ),
        RepositoryProvider<NewsRepository>(
          create: (context) => newsRepository,
        ),
        RepositoryProvider<LectureRepository>(
          create: (context) => lectureRepository,
        ),
        RepositoryProvider<TemplateRepository>(
          create: (context) => templateRepository,
        ),
        RepositoryProvider<OpenAIChatRepository>(
          create: (context) => openAIChatRepository,
        ),
        // ✅ Added missing notification repositories
        RepositoryProvider<NotificationRepository>(
          create: (context) => notificationRepository,
        ),
        RepositoryProvider<GetNotificationRepository>(
          create: (context) => getNotificationRepository,
        ),
        RepositoryProvider<NotificationDetailsRepository>(
          create: (context) => notificationDetailsRepository,
        ),
        RepositoryProvider<CounterRepository>(
          create: (context) => counterRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GoogleCubit(
              context.read<GoogleRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(
              context.read<StudentRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AlumniRegisterCubit(
              context.read<AlumniRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => VerifyEmailCubit(
              context.read<VerifyEmailRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoginScreenCubit(
              context.read<LoginRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ForgetPassScreenCubit(
              context.read<SendEmailRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SendCodeCubit(
              context.read<ResetPasswordRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => RePasswordCubit(
              context.read<ChangePasswordRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(
              context.read<NotificationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationScreenViewModel(
              context.read<GetNotificationRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationDetailsViewModel(
              context.read<NotificationDetailsRepository>(),
              context.read<CounterRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NewsCubit(context.read<NewsRepository>()),
          ),
          BlocProvider(
            create: (context) => LectureCubit(context.read<LectureRepository>()),
          ),
          BlocProvider(
            create: (context) => TemplateCubit(context.read<TemplateRepository>()),
          ),
          BlocProvider(
            create: (context) => OpenAIChatCubit(
              context.read<OpenAIChatRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: MyColors.primaryColor),
          locale: const Locale('ar', ''),
          supportedLocales: const [
            Locale('ar', ''),
            Locale('en', '')
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: studentHomescreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            StudentRegisterScreen.routeName: (context) => StudentRegisterScreen(role: ''),
            AlumniRegisterScreen.routeName: (context) => AlumniRegisterScreen(role: ''),
            ForgetPassScreen.routeName: (context) => ForgetPassScreen(),
            GraduatedHomeScreen.routeName: (context) => GraduatedHomeScreen(),
            splashScreen.routeName: (context) => splashScreen(),
            account_type.routeName: (context) => account_type(),
            HomeScreen.routeName: (context) => HomeScreen(),
            studentHomescreen.routeName: (context) => studentHomescreen(),
            TrainingPage.routeName: (context) => TrainingPage(),
            DashboardPage.routeName: (context) => DashboardPage(),
            PostgraduatStudies.routeName: (context) => PostgraduatStudies(),
            Subjects_Screen.routeName: (context) => Subjects_Screen(),
            OnBoarding.routeName: (context) => OnBoarding(),
          //  ChatScreen.routeName: (context) => ChatScreen(),
            Examscreen.routeName: (context) => Examscreen(),
            ResultScreen.routeName: (context) => ResultScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen()
          },
        );
      },
    );
  }
}