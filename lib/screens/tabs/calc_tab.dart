import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CalcTab extends StatefulWidget {
  const CalcTab({super.key});

  @override
  State<CalcTab> createState() => _CalcTabState();
}

class _CalcTabState extends State<CalcTab> {
  double _weight = 75;
  int _minutes = 30;
  String _intensity = 'Moderate';

  int _calculateCalories() {
    double met = 6.0;
    if (_intensity == 'Light') met = 4.0;
    if (_intensity == 'Intense') met = 9.0;
    if (_intensity == 'Insane') met = 12.0;
    return ((met * 3.5 * _weight / 200) * _minutes).round();
  }

  @override
  Widget build(BuildContext context) {
    final calories = _calculateCalories();
    return Scaffold(
      appBar: AppBar(title: const Text('Calorie Burn Estimator'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('Estimated Calories Burned', style: TextStyle(color: AppTheme.textSecondary)),
                  const SizedBox(height: 12),
                  Text('$calories kcal', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Body Weight: ${_weight.round()} kg', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: _weight,
                    min: 40,
                    max: 150,
                    activeColor: AppTheme.primary,
                    onChanged: (val) => setState(() => _weight = val),
                  ),
                  const SizedBox(height: 16),
                  Text('Workout Duration: $_minutes min', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: _minutes.toDouble(),
                    min: 5,
                    max: 90,
                    divisions: 17,
                    activeColor: AppTheme.primary,
                    onChanged: (val) => setState(() => _minutes = val.round()),
                  ),
                  const SizedBox(height: 16),
                  const Text('Intensity Level', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: ['Light', 'Moderate', 'Intense', 'Insane'].map((level) {
                      final selected = _intensity == level;
                      return ChoiceChip(
                        label: Text(level),
                        selected: selected,
                        selectedColor: AppTheme.primary.withValues(alpha: 0.3),
                        onSelected: (_) => setState(() => _intensity = level),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
