import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const RaccoonAiApp());
}

class RaccoonAiApp extends StatefulWidget {
  const RaccoonAiApp({super.key});

  @override
  State<RaccoonAiApp> createState() => _RaccoonAiAppState();
}

class _RaccoonAiAppState extends State<RaccoonAiApp> {
  static const _animationKey = 'mascot_animations_enabled';
  bool _animationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _animationsEnabled = preferences.getBool(_animationKey) ?? true;
    });
  }

  Future<void> _setAnimationsEnabled(bool value) async {
    setState(() => _animationsEnabled = value);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_animationKey, value);
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF0D1110);
    const surface = Color(0xFF171D1B);
    const accent = Color(0xFFA8B8AD);

    return MaterialApp(
      title: 'Raccoon AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: Color(0xFF879A8E),
          surface: surface,
          onSurface: Color(0xFFE8ECE9),
          onSurfaceVariant: Color(0xFF9AA59E),
          outlineVariant: Color(0xFF303A34),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        fontFamily: 'Roboto',
      ),
      home: AssistantHome(
        animationsEnabled: _animationsEnabled,
        onAnimationsChanged: _setAnimationsEnabled,
      ),
    );
  }
}

class AssistantHome extends StatelessWidget {
  const AssistantHome({
    required this.animationsEnabled,
    required this.onAnimationsChanged,
    super.key,
  });

  final bool animationsEnabled;
  final ValueChanged<bool> onAnimationsChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 22,
        title: const Row(
          children: [
            Icon(Icons.circle, size: 8, color: Color(0xFFA8B8AD)),
            SizedBox(width: 10),
            Text(
              'RACCOON',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.1,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => SettingsPage(
                    animationsEnabled: animationsEnabled,
                    onAnimationsChanged: onAnimationsChanged,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: 230,
              height: 250,
              child: RaccoonMascot(animationsEnabled: animationsEnabled),
            ),
            const SizedBox(height: 18),
            Text(
              'At your side.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.8,
                  ),
            ),
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Text(
                'A private assistant. Your device. Your rules.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      letterSpacing: 0.15,
                      height: 1.5,
                    ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 26),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.65)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.memory_rounded, size: 20, color: Color(0xFFA8B8AD)),
                  SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOCAL MODEL NOT CONNECTED',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'The interface is ready for integration. No messages are sent to a cloud AI.',
                          style: TextStyle(
                            color: Color(0xFF9AA59E),
                            height: 1.45,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 8, 18, 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.65)),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: colors.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Connect a local model to begin',
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
                    ),
                  ),
                  Icon(Icons.mic_none_rounded, color: colors.onSurfaceVariant),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'PRIVATE BY DESIGN',
                style: TextStyle(
                  color: Color(0xFF657169),
                  fontSize: 9,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.animationsEnabled,
    required this.onAnimationsChanged,
    super.key,
  });

  final bool animationsEnabled;
  final ValueChanged<bool> onAnimationsChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const _SettingsSectionTitle('APPEARANCE'),
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            title: const Text('Mascot animations'),
            subtitle: const Text('Enable subtle companion movement'),
            value: animationsEnabled,
            onChanged: onAnimationsChanged,
          ),
          const SizedBox(height: 24),
          const _SettingsSectionTitle('PRIVACY'),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2),
            leading: Icon(Icons.phonelink_lock_outlined),
            title: Text('On-device processing'),
            subtitle: Text(
              'Local AI is the planned default. A model has not been connected yet.',
            ),
          ),
          Divider(color: colors.outlineVariant),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2),
            leading: Icon(Icons.history_rounded),
            title: Text('Conversation storage'),
            subtitle: Text(
              'Local conversation history will be added with the chat engine.',
            ),
          ),
          const SizedBox(height: 24),
          const _SettingsSectionTitle('ABOUT'),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2),
            title: Text('Raccoon AI'),
            subtitle: Text('Early development build • 0.1.0'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  const _SettingsSectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFA8B8AD),
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}

class RaccoonMascot extends StatefulWidget {
  const RaccoonMascot({required this.animationsEnabled, super.key});

  final bool animationsEnabled;

  @override
  State<RaccoonMascot> createState() => _RaccoonMascotState();
}

class _RaccoonMascotState extends State<RaccoonMascot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _float = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.animationsEnabled) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant RaccoonMascot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationsEnabled == oldWidget.animationsEnabled) return;
    if (widget.animationsEnabled) {
      _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.value = 0.5;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _float.value),
        child: child,
      ),
      child: CustomPaint(
        painter: _RaccoonPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _RaccoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 230;
    canvas.save();
    canvas.translate(0, (size.height - 250 * scale) / 2);
    canvas.scale(scale);

    final fur = Paint()..color = const Color(0xFF8D9690);
    final furLight = Paint()..color = const Color(0xFFB6BDB7);
    final furShade = Paint()..color = const Color(0xFF626D66);
    final mask = Paint()..color = const Color(0xFF252D29);
    final innerEar = Paint()..color = const Color(0xFF9B7772);
    final chest = Paint()..color = const Color(0xFFD0D0C5);
    final eye = Paint()..color = const Color(0xFF111714);
    final nose = Paint()..color = const Color(0xFF202522);
    final shadow = Paint()..color = const Color(0x44000000);

    canvas.drawOval(const Rect.fromLTWH(48, 222, 136, 12), shadow);

    final body = Path()
      ..moveTo(47, 229)
      ..cubicTo(50, 194, 66, 174, 91, 164)
      ..lineTo(140, 164)
      ..cubicTo(166, 176, 182, 198, 185, 229)
      ..close();
    canvas.drawPath(body, furShade);

    final bib = Path()
      ..moveTo(91, 164)
      ..cubicTo(98, 176, 103, 190, 115, 211)
      ..cubicTo(127, 190, 134, 176, 140, 164)
      ..cubicTo(158, 178, 169, 197, 172, 229)
      ..lineTo(61, 229)
      ..cubicTo(65, 198, 75, 179, 91, 164)
      ..close();
    canvas.drawPath(bib, chest);

    final leftEar = Path()
      ..moveTo(67, 91)
      ..cubicTo(57, 66, 54, 35, 62, 17)
      ..cubicTo(83, 24, 99, 42, 104, 68)
      ..close();
    canvas.drawPath(leftEar, furShade);
    final leftEarInner = Path()
      ..moveTo(69, 69)
      ..cubicTo(66, 49, 66, 37, 68, 31)
      ..cubicTo(81, 39, 89, 51, 93, 69)
      ..close();
    canvas.drawPath(leftEarInner, innerEar);

    final rightEar = Path()
      ..moveTo(128, 68)
      ..cubicTo(136, 42, 153, 24, 174, 17)
      ..cubicTo(181, 39, 176, 69, 162, 92)
      ..close();
    canvas.drawPath(rightEar, furShade);
    final rightEarInner = Path()
      ..moveTo(139, 68)
      ..cubicTo(145, 51, 157, 39, 169, 31)
      ..cubicTo(171, 45, 168, 59, 161, 72)
      ..close();
    canvas.drawPath(rightEarInner, innerEar);

    final head = Path()
      ..moveTo(65, 71)
      ..cubicTo(78, 49, 99, 40, 119, 40)
      ..cubicTo(143, 40, 164, 54, 174, 78)
      ..cubicTo(185, 105, 177, 145, 158, 166)
      ..cubicTo(146, 180, 133, 187, 119, 188)
      ..cubicTo(103, 186, 88, 178, 77, 164)
      ..cubicTo(57, 142, 53, 98, 65, 71)
      ..close();
    canvas.drawPath(head, fur);
    canvas.drawPath(
      head,
      Paint()
        ..color = const Color(0xFF657169)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    final leftMask = Path()
      ..moveTo(62, 94)
      ..cubicTo(76, 77, 96, 75, 112, 88)
      ..cubicTo(108, 107, 98, 122, 81, 128)
      ..cubicTo(67, 122, 60, 109, 62, 94)
      ..close();
    final rightMask = Path()
      ..moveTo(126, 88)
      ..cubicTo(144, 75, 164, 78, 177, 96)
      ..cubicTo(178, 111, 169, 124, 155, 129)
      ..cubicTo(139, 121, 130, 106, 126, 88)
      ..close();
    canvas.drawPath(leftMask, mask);
    canvas.drawPath(rightMask, mask);

    final leftEye = Path()
      ..moveTo(78, 101)
      ..quadraticBezierTo(88, 94, 99, 101)
      ..quadraticBezierTo(89, 108, 78, 101)
      ..close();
    final rightEye = Path()
      ..moveTo(141, 101)
      ..quadraticBezierTo(152, 94, 162, 101)
      ..quadraticBezierTo(152, 108, 141, 101)
      ..close();
    canvas.drawPath(leftEye, eye);
    canvas.drawPath(rightEye, eye);
    final glint = Paint()..color = const Color(0xFFDDE4DE);
    canvas.drawCircle(const Offset(91, 99), 1.5, glint);
    canvas.drawCircle(const Offset(154, 99), 1.5, glint);

    final muzzle = Path()
      ..moveTo(105, 108)
      ..cubicTo(109, 101, 114, 99, 119, 99)
      ..cubicTo(125, 99, 131, 104, 135, 111)
      ..cubicTo(132, 129, 126, 141, 119, 145)
      ..cubicTo(111, 140, 106, 127, 105, 108)
      ..close();
    canvas.drawPath(muzzle, furLight);
    final nosePath = Path()
      ..moveTo(112, 122)
      ..quadraticBezierTo(119, 117, 126, 122)
      ..quadraticBezierTo(125, 128, 119, 129)
      ..quadraticBezierTo(113, 128, 112, 122)
      ..close();
    canvas.drawPath(nosePath, nose);

    final hair = Paint()
      ..color = const Color(0xFF657169)
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 5; i++) {
      final y = 147.0 + i * 5;
      canvas.drawLine(Offset(75 + i * 2.0, y), Offset(91 + i * 2.0, y + 5), hair);
      canvas.drawLine(Offset(147 - i * 2.0, y), Offset(132 - i * 2.0, y + 5), hair);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RaccoonPainter oldDelegate) => false;
}
