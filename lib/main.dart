import 'package:flutter/material.dart';

void main() {
  runApp(const RaccoonAiApp());
}

class RaccoonAiApp extends StatelessWidget {
  const RaccoonAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF8BAA91);
    return MaterialApp(
      title: 'Raccoon AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
          surface: const Color(0xFF151A18),
        ),
        scaffoldBackgroundColor: const Color(0xFF101412),
        fontFamily: 'Roboto',
      ),
      home: const AssistantHome(),
    );
  }
}

class AssistantHome extends StatelessWidget {
  const AssistantHome({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, size: 19),
            SizedBox(width: 9),
            Text('Raccoon AI', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Settings (coming soon)',
            onPressed: () => _showNotice(context, 'Settings are not implemented yet.'),
            icon: const Icon(Icons.tune_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            const SizedBox(
              width: 190,
              height: 190,
              child: RaccoonMascot(),
            ),
            const SizedBox(height: 24),
            Text(
              'Hey, I’m Raccoon.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.7,
                  ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Text(
                'Your assistant, designed to keep your conversations on your device.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.45,
                    ),
              ),
            ),
            const SizedBox(height: 26),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.48),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.45)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.memory_rounded, size: 21),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Local AI isn’t connected yet',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 5),
                        Text(
                          'This is the interface foundation. A local model needs to be installed and connected before chat can work.',
                          style: TextStyle(height: 1.4, fontSize: 13),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: colors.surfaceContainer,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: colors.onSurfaceVariant),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Local model required to chat',
                      style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
                    ),
                  ),
                  Icon(Icons.mic_none_rounded, color: colors.onSurfaceVariant),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'PRIVATE BY DESIGN  •  WORK IN PROGRESS',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant.withValues(alpha: 0.75),
                      letterSpacing: 1.2,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class RaccoonMascot extends StatelessWidget {
  const RaccoonMascot({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RaccoonPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _RaccoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 190;
    final sy = size.height / 190;
    canvas.save();
    canvas.scale(sx, sy);

    final shadow = Paint()..color = const Color(0x55000000);
    canvas.drawOval(const Rect.fromLTWH(29, 158, 132, 17), shadow);

    final outline = Paint()
      ..color = const Color(0xFF252C29)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeJoin = StrokeJoin.round;

    final fur = Paint()..color = const Color(0xFF929D98);
    final ear = Paint()..color = const Color(0xFF707C77);
    final innerEar = Paint()..color = const Color(0xFFC58D88);
    final mask = Paint()..color = const Color(0xFF303936);
    final cream = Paint()..color = const Color(0xFFE6E2D5);
    final eye = Paint()..color = const Color(0xFF171D1A);
    final nose = Paint()..color = const Color(0xFF292D2B);

    Path polygon(List<Offset> points) => Path()..addPolygon(points, true);

    final leftEar = polygon(const [
      Offset(39, 62), Offset(43, 17), Offset(78, 42), Offset(78, 70),
    ]);
    canvas.drawPath(leftEar, ear);
    canvas.drawPath(leftEar, outline);
    canvas.drawPath(
      polygon(const [Offset(49, 48), Offset(51, 29), Offset(68, 46), Offset(67, 59)]),
      innerEar,
    );

    final rightEar = polygon(const [
      Offset(112, 42), Offset(148, 17), Offset(153, 63), Offset(114, 70),
    ]);
    canvas.drawPath(rightEar, ear);
    canvas.drawPath(rightEar, outline);
    canvas.drawPath(
      polygon(const [Offset(124, 46), Offset(143, 29), Offset(145, 49), Offset(127, 59)]),
      innerEar,
    );

    final head = polygon(const [
      Offset(48, 48), Offset(73, 35), Offset(119, 35), Offset(145, 53),
      Offset(157, 91), Offset(145, 132), Offset(116, 154), Offset(76, 154),
      Offset(45, 131), Offset(33, 91),
    ]);
    canvas.drawPath(head, fur);
    canvas.drawPath(head, outline);

    canvas.drawPath(
      polygon(const [
        Offset(43, 82), Offset(69, 64), Offset(91, 79), Offset(85, 105),
        Offset(61, 115), Offset(43, 105),
      ]),
      mask,
    );
    canvas.drawPath(
      polygon(const [
        Offset(99, 79), Offset(122, 64), Offset(148, 82), Offset(148, 105),
        Offset(130, 115), Offset(105, 105),
      ]),
      mask,
    );

    canvas.drawCircle(const Offset(72, 91), 5.2, eye);
    canvas.drawCircle(const Offset(124, 91), 5.2, eye);
    final glint = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(73.5, 89.5), 1.5, glint);
    canvas.drawCircle(const Offset(125.5, 89.5), 1.5, glint);

    canvas.drawPath(
      polygon(const [
        Offset(70, 119), Offset(91, 108), Offset(105, 108), Offset(126, 119),
        Offset(111, 139), Offset(85, 139),
      ]),
      cream,
    );
    canvas.drawPath(
      polygon(const [Offset(91, 115), Offset(105, 115), Offset(101, 124), Offset(95, 124)]),
      nose,
    );
    final mouth = Paint()
      ..color = const Color(0xFF343A36)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    final smile = Path()
      ..moveTo(98, 124)
      ..quadraticBezierTo(94, 133, 87, 128)
      ..moveTo(98, 124)
      ..quadraticBezierTo(103, 133, 110, 128);
    canvas.drawPath(smile, mouth);

    final chest = polygon(const [
      Offset(68, 151), Offset(82, 141), Offset(112, 141), Offset(127, 152),
      Offset(139, 177), Offset(54, 177),
    ]);
    canvas.drawPath(chest, cream);
    canvas.drawPath(chest, outline);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RaccoonPainter oldDelegate) => false;
}
