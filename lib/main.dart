import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_college/Cubits/Auth/Login/GoogleViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/forget_passViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/loginScreenViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/re-passViewModel.dart';
import 'package:smart_college/Cubits/Auth/Login/send_codeViewModel.dart';
import 'package:smart_college/Repositories/ChangePasswordRepository.dart';
import 'package:smart_college/Repositories/GoogleRepository.dart';
import 'package:smart_college/Repositories/ResetPasswordRepository.dart';
import 'package:smart_college/Repositories/SendEmailRepository.dart';
import 'package:smart_college/Repositories/TemplateRepository.dart';
import 'package:smart_college/Repositories/VerifyEmailRepository.dart';
import 'package:smart_college/View/Auth/Login/forget_pass.dart';
import 'package:smart_college/View/Auth/Login/re_pass.dart';
import 'package:smart_college/View/Auth/Login/send_code.dart';
import 'package:smart_college/View/Auth/Register/alumniRegister.dart';
import 'package:smart_college/View/Auth/Register/roleselection.dart';
import 'package:smart_college/View/Auth/Register/studentRegister.dart';
import 'package:smart_college/View/Auth/Register/verifyEmail.dart';
import 'package:smart_college/View/Graduated/home/dashboard.dart';
import 'package:smart_college/View/Graduated/home/graduatedHomeScreen.dart';
import 'package:smart_college/View/Graduated/home/postgraduat_%20studies.dart';
import 'package:smart_college/View/Graduated/home/training.dart';
import 'package:smart_college/View/Student/studentHomeScreen.dart';
import 'package:smart_college/View/Student/subjects.dart';
import 'package:smart_college/View/home/splashScreen.dart';
import 'package:smart_college/View/home/homeScreen.dart';
import 'package:smart_college/services/remote/apiManager.dart';
import 'package:smart_college/sources/AlumniRegisterDataSource.dart';
import 'package:smart_college/sources/ChangePasswordDataSource.dart';
import 'package:smart_college/sources/GoogleDataSource.dart';
import 'package:smart_college/sources/LoginDataSource.dart';
import 'package:smart_college/sources/ResetPasswordDataSource.dart';
import 'package:smart_college/sources/SendEmailDataSource.dart';
import 'package:smart_college/sources/StudentRegisterDataSource.dart';
import 'package:smart_college/sources/VerifyEmailDataSource.dart';
import 'package:smart_college/sources/NewsDataSource.dart';
import 'package:smart_college/sources/LectureDataSource.dart';
import 'package:smart_college/sources/TemplateDataSource.dart';
import 'package:smart_college/utils/colors.dart';

import 'Cubits/Auth/Register/AlumniRegisterViewModel.dart';
import 'Cubits/Auth/Register/SyudentRegisterViewModel.dart';
import 'Cubits/Auth/Register/VerifyemailViewModel.dart';
import 'Cubits/News/NewsCubit.dart';
import 'Cubits/lectures/LectureCubit.dart';
import 'Cubits/Templates/TemplateCubit.dart';
import 'Repositories/AlumniRegisterRepository.dart';
import 'Repositories/LoginRepository.dart';
import 'Repositories/StudentRegisterRepository.dart';
import 'Repositories/NewsRepository.dart';
import 'Repositories/LectureRepositort.dart';
import 'View/Auth/Login/login.dart';
import 'package:smart_college/View/home/accountType.dart';
void main() {
  final apiManager = ApiManager();
  final studentRemoteDataSource = StudentRemoteDataSource(apiManager);
  final studentRepository = StudentRepository(studentRemoteDataSource);

  // Alumni repo
  final alumniRemoteDataSource = AlumniRemoteDataSource(apiManager);
  final alumniRepository = AlumniRepository(alumniRemoteDataSource);

  final verifyEmailRemoteDataSource = VerifyEmailRemoteDataSource(apiManager);
  final verifyEmail = VerifyEmailRepository(verifyEmailRemoteDataSource);

  //login
  final loginRemoteDataSource = LoginRemoteDataSource(apiManager);
  final loginRepository = LoginRepository(loginRemoteDataSource);

  //sendemail
  final sendEmailRemoteDataSource = SendEmailRemoteDataSource(apiManager);
  final sendEmail = SendEmailRepository(sendEmailRemoteDataSource);

  //sendcode
  final resetPasswordRemoteDataSource = ResetPasswordRemoteDataSource(
    apiManager,
  );
  final sendCode = ResetPasswordRepository(resetPasswordRemoteDataSource);

  //changepass
  final changePassRemoteDataSource = ChangePassRemoteDataSource(apiManager);
  final changePass = ChangePasswordRepository(changePassRemoteDataSource);

  //google
  final googleDataSource = GoogleDataSource(apiManager);
  final google = GoogleRepository(googleDataSource);

  //news
  final newsRemoteDataSource = NewsRemoteDataSource(apiManager);
  final newsRepository = NewsRepository(newsRemoteDataSource);

  //lectures
  final lectureRemoteDataSource = LectureRemoteDataSource(apiManager: apiManager);
  final lectureRepository = LectureRepository(remoteDataSource: lectureRemoteDataSource);

  //templates
  final templateRemoteDataSource = TemplateRemoteDataSource(apiManager);
  final templateRepository = TemplateRepository(templateRemoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GoogleRepository>(create: (context) => google),
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

        RepositoryProvider<SendEmailRepository>(create: (context) => sendEmail),

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GoogleCubit(context.read<GoogleRepository>()),
          ),
          BlocProvider(
            create:
                (context) => RegisterCubit(context.read<StudentRepository>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    AlumniRegisterCubit(context.read<AlumniRepository>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    VerifyEmailCubit(context.read<VerifyEmailRepository>()),
          ),

          BlocProvider(
            create:
                (context) => LoginScreenCubit(context.read<LoginRepository>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    ForgetPassScreenCubit(context.read<SendEmailRepository>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    SendCodeCubit(context.read<ResetPasswordRepository>()),
          ),

          BlocProvider(
            create:
                (context) =>
                    RePasswordCubit(context.read<ChangePasswordRepository>()),
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
      designSize: const Size(393, 805),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: MyColors.primaryColor),

          locale: Locale('ar', ''),
          supportedLocales: [Locale('ar', ''), Locale('en', '')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          initialRoute: Subjects_Screen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            StudentRegisterScreen.routeName:
                (context) => StudentRegisterScreen(role: ''),
            AlumniRegisterScreen.routeName:
                (context) => AlumniRegisterScreen(role: ''),
            ForgetPassScreen.routeName: (context) => ForgetPassScreen(),
            //SendCode.routeName : (context) => SendCode(),
            //RePassword.routeName : (context) => RePassword(),
            RoleSelectionScreen.routeName: (context) => RoleSelectionScreen(),
            GraduatedHomeScreen.routeName: (context) => GraduatedHomeScreen(),
            // VerifyEmail.routeName : (context) => VerifyEmail(userId: userId)
            splashScreen.routeName: (context) => splashScreen(),
               account_type.routeName: (context) => account_type(),
            HomeScreen.routeName: (context) => HomeScreen(),
            studentHomescreen.routeName: (context) => studentHomescreen(),
             TrainingPage.routeName: (context) => TrainingPage(),
             DashboardPage.routeName : (context) => DashboardPage(),
             PostgraduatStudies.routeName : (context) => PostgraduatStudies(),
              Subjects_Screen.routeName : (context) => Subjects_Screen(),
          },
        );
      },
    );
  }
}
