import 'package:flutter_svg/flutter_svg.dart';

class AppImage {
  static final logo = SvgPicture.asset(
    'assets/logo.svg',
    semanticsLabel: 'Riquinho logo',
  );
  static final mailSent = SvgPicture.asset(
    'assets/mail_sent.svg',
    semanticsLabel:
        'Envelope de carta aberto com um simbolo de checado de cor verde',
  );
}
