import 'dart:io';

import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama_offices/app.dart';
import 'dart:math';

import '../../../core/values/colors.dart';
import '../../../core/widget/TextWidget.dart';
import '../../home/home_core.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutPreviewViewState();
}

class _CheckoutPreviewViewState extends State<CheckoutView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  ConfettiController? controllerBottomCenter;

  @override
  void initState() {
    controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animationListener();
    animationController?.forward();
    super.initState();
  }

  animationListener() {
    animationController?.addListener(() {
      setState(() {
        controllerBottomCenter?.play();
        Future.delayed(const Duration(seconds: 5), () {
          controllerBottomCenter?.stop();
        });
        animationController?.stop();
      });
    });
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void dispose() {
    animationController?.dispose();
    // controllerBottomCenter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                "assets/images/logo.svg",
                height: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              TextWidget(
                title: "ThankYou".tr(),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                  title: "Subscription".tr(),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: darkBlue,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 25,
              ),

              const SizedBox(
                height: 25,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    SamaOfficesApp.navKey.currentState!.pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>  HomeCore()),
                            (route) => false);
                  },
                  style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: samaOfficeColor,
                      fixedSize: const Size(350, 50)),
                  child: Text(
                    tr('GotOhome'),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: controllerBottomCenter!,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
                maxBlastForce: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
