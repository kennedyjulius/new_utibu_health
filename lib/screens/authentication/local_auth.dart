// ignore_for_file: prefer_const_constructors, avoid_print, annotate_overrides, empty_catches

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:new_utibu_health_app/screens/authentication/login_screen.dart';



class LocalAuth extends StatefulWidget {
  const LocalAuth({super.key});

  @override
  State<LocalAuth> createState() => _LocalAuthState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _LocalAuthState extends State<LocalAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;

  List<BiometricType>? availableBiometrics;

  void initState() {
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportState =
            isSupported ? SupportState.supported : SupportState.unSupported));
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometrics supported: $canCheckBiometric");
    } catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("Supported biometrics $biometricTypes");
    } catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: "Authenticate with fingerprint or Face ID",
          options: AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (!mounted) {
        return;
      }

      if (authenticated) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
