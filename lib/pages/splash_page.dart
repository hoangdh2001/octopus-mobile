import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octopus/di/service_locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

mixin SplashScreenStateMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  late Animation<double> animation, scaleAnimation;
  late AnimationController _animationController, _scaleAnimationController;
  late Animation<Color?> colorAnimation;
  bool animationCompleted = false;
  late Brightness? mode;

  void _createAnimations() {
    final snap = getIt<StreamingSharedPreferences>()
        .getInt("theme", defaultValue: 0)
        .getValue();

    mode = {
      -1: Brightness.dark,
      0: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .platformBrightness,
      1: Brightness.light,
    }[snap];
    _scaleAnimationController = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    scaleAnimation = Tween(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOutBack,
    ));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    animation = Tween(
      begin: 0.0,
      end: 1000.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    colorAnimation = ColorTween(
      begin: mode == Brightness.dark ? const Color(0xFF121212) : Colors.white,
      end: mode == Brightness.dark ? const Color(0xFF121212) : Colors.white,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    colorAnimation = ColorTween(
      begin: mode == Brightness.dark ? const Color(0xFF121212) : Colors.white,
      end: Colors.transparent,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void forwardAnimations() {
    _scaleAnimationController.forward().whenComplete(() {
      _animationController.forward();
    });
  }

  Widget buildAnimation() => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: scaleAnimation,
            builder: (context, _) {
              return Transform.scale(
                scale: scaleAnimation.value,
                child: AnimatedBuilder(
                    animation: colorAnimation,
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints.expand(),
                        color: colorAnimation.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            !_animationController.isAnimating
                                ? Image.asset(
                                    mode == Brightness.dark
                                        ? 'assets/logo/logo-splash-dark.png'
                                        : 'assets/logo/logo-splash-light.png',
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                    width: 0.7.sw,
                                  )
                                : const SizedBox(),
                            if (!_animationController.isAnimating)
                              Positioned(
                                bottom: 0,
                                child: _getIndicatorWidget(
                                    Theme.of(context).platform),
                              ),
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, snapshot) {
              return Transform.scale(
                scale: animation.value,
                child: Container(
                  width: 1.0,
                  height: 1.0,
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(1 - _animationController.value),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ],
      );

  Widget _getIndicatorWidget(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
        return const CupertinoActivityIndicator(
          color: Colors.grey,
        );
      case TargetPlatform.android:
      default:
        return const CircularProgressIndicator(
          color: Colors.grey,
        );
    }
  }

  @override
  void initState() {
    _createAnimations();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationCompleted = true;
        });
      }
    });
    super.initState();
  }
}
