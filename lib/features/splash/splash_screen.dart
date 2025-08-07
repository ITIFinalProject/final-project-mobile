// import 'package:eventify_app/core/routes.dart';
// import 'package:eventify_app/core/theme.dart';
// import 'package:eventify_app/features/auth/cubit/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../auth/cubit/auth_cubit.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<AuthCubit>().checkUserLoggedIn();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           Navigator.pushReplacementNamed(context, AppRoutes.layout);
//         } else if (state is AuthLoggedOut) {
//           Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(

//           child: Image.asset(
//             'assets/images/logo_light.jpeg',
//              width: MediaQuery.of(context).size.width * 0.6,   // 60% من عرض الشاشة
//       height: MediaQuery.of(context).size.height * 0.3, // 30% من ارتفاع الشاشة
//       fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eventify_app/core/routes.dart';
import 'package:eventify_app/core/theme.dart';
import 'package:eventify_app/features/auth/cubit/auth_cubit.dart';
import 'package:eventify_app/features/auth/cubit/auth_state.dart';
import 'package:eventify_app/features/profile/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final bool isDark = themeMode == ThemeMode.dark;

        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.layout);
            } else if (state is AuthLoggedOut) {
              Navigator.pushReplacementNamed(context, AppRoutes.onBoarding);
            } else if (state is AuthFailure &&
                state.error ==
                    "Your account has been disabled by the administration.") {
              showErrorDialog(title: 'Account Disable',
                  desc: "Your account has been disabled by the administration.");
            } else if (state is AuthFailure &&
                state.error ==
                    "Your account has been banned for 30 days. Please try again later.") {
              showErrorDialog(title: 'Account Banned',
                  desc: "Your account has been banned for 30 days. Please try again later.");
            }
          },

          child: Scaffold(
            backgroundColor: isDark ? ThemeManager.primaryColor : Colors.white,
            body: Center(
              child: Image.asset(
                isDark
                    ? 'assets/images/logo_dark.png'
                    : 'assets/images/logo_light.jpeg',
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.6,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  showErrorDialog({required String title, required String desc}) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )
      ..show();
  }
}
