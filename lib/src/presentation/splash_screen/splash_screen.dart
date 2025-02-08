import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/src/application/login/login_cubit.dart';
import 'package:login_app/src/core/auth_service.dart';
import 'package:login_app/src/utils/router/app_router.gr.dart';
import 'package:video_player/video_player.dart';

// import 'package:flutter/services.dart';
@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();
  late VideoPlayerController controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset('assets/videos/splash_video.mp4')
      ..initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
        controller
          ..setLooping(false) // No looping
          ..setVolume(0.0) // Mute video
          ..play(); // Start playing

        // Navigate after 3.5 seconds
        Future.delayed(
            const Duration(milliseconds: 3500), navigateToNextScreen);
      });
  }

  void navigateToNextScreen() {
    final state = context.read<LoginCubit>().state;
    if (state.isUserAuthenticated) {
      context.router.pushAndPopUntil(
        HomeRoute(user: state.googleUser!, authService: authService),
        predicate: (route) => false,
      );
    } else {
      context.router.pushAndPopUntil(
        LoginRoute(),
        predicate: (route) => false,
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          isInitialized
              ? VideoPlayer(controller)
              : const Center(child: CircularProgressIndicator()),
          const Center(
            child: Text(
              "WELCOME",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
