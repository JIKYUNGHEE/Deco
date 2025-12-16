import 'package:flutter/material.dart';
import '../core/themes/app_colors.dart';

class ThemePreviewPage extends StatelessWidget {
  const ThemePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _section('Text Styles'),
            const SizedBox(height: 8),
            Text('Title Large, 제목 라지', style: Theme.of(context).textTheme.titleLarge),
            Text('Title Medium, 제목 미디엄', style: Theme.of(context).textTheme.titleMedium),
            Text('Body Large, 바디 라지', style: Theme.of(context).textTheme.bodyLarge),
            Text('Body Medium, 바디 미디엄', style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 24),
            _section('Buttons'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Elevated'),
                ),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined'),
                ),
              ],
            ),

            const SizedBox(height: 24),
            _section('Input Fields'),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: '이메일',
                hintText: 'example@email.com',
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
            ),

            const SizedBox(height: 24),
            _section('Cards'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('코스 카드 제목', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('이 카드로 둥근 모서리, 테두리, 배경색을 확인합니다.'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            _section('Gradients'),
            const SizedBox(height: 12),
            _gradientBox(AppColors.brandGradient, 'Brand Gradient'),
            const SizedBox(height: 12),
            _gradientBox(AppColors.warmGradient, 'Warm Gradient'),

            const SizedBox(height: 24),
            _section('Bottom Sheet'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bottom Sheet Title',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        const Text('바텀시트 배경/텍스트/버튼 톤 확인'),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Open Bottom Sheet'),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _section(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _gradientBox(Gradient gradient, String label) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
