import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_sphere/src/application/login/login_cubit.dart';
import 'package:sign_sphere/src/core/service/auth_service.dart';
import 'package:sign_sphere/src/utils/router/app_router.gr.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController? controller;
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeOut),
    );

    String videoPath = 'assets/videos/splash_video.mp4';

    controller = VideoPlayerController.asset(videoPath)
      ..initialize().then(
        (_) {
          setState(() {});
          controller!
            ..setLooping(false)
            ..setVolume(0.0)
            ..play();

          Timer(
            kIsWeb
                ? const Duration(milliseconds: 2800)
                : const Duration(milliseconds: 4000),
            _navigateToNextScreen,
          );
        },
      );
  }

  void _navigateToNextScreen() {
    fadeController.forward().then(
      (_) {
        final state = context.read<LoginCubit>().state;
        context.router.replace(
          state.isUserAuthenticated
              ? HomeRoute(user: state.googleUser!, authService: authService)
              : LoginRoute(),
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: fadeAnimation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (controller != null && controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: controller!.value.aspectRatio,
                child: VideoPlayer(controller!),
              ),
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
      ),
    );
  }
}
