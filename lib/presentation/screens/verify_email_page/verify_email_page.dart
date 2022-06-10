import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/business_logic.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  late Timer timer;

  @override
  void initState() {
    context.read<RegisterUserCubit>().emailSent();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final isEmailVerified =
          await context.read<RegisterUserCubit>().emailVerified();
      if (isEmailVerified) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, kHomePath);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: AppImage.mailSent,
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              AppText.kTitleEmailVerificationPage,
              textAlign: TextAlign.center,
              style:
                  AppTypograph.headline4.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppText.kSubtitleEmailVerificationPage,
              textAlign: TextAlign.center,
              style: AppTypograph.headline6.copyWith(color: Colors.black54),
            ),
            const SizedBox(
              height: 80,
            ),
            CustomRichText(
                text: 'Não recebeu o e-mail? ',
                clickableText: 'Reenviar e-mail',
                onTap: () => context.read<RegisterUserCubit>().emailSent())
          ],
        ),
      ),
    );
  }
}
