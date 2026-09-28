import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WorkoutsTab extends StatelessWidget {
  const WorkoutsTab({super.key});

  final List<Map<String, dynamic>> exercises = const [
    {"title": "Burpee Sprints", "reps": "45s Work / 15s Rest", "target": "Full Body, Cardio"},
    {"title": "Mountain Climbers", "reps": "40s Work / 20s Rest", "target": "Core, Agility"},
    {"title": "Jump Squats", "reps": "45s Work / 15s Rest", "target": "Quads, Explosive Power"},
    {"title": "High Knees Blitz", "reps": "30s Work / 10s Rest", "target": "Cardiovascular Stamina"},
    {"title": "Plank Jacks", "reps": "40s Work / 20s Rest", "target": "Shoulders, Lower Core"},
    {"title": "Kettlebell Swings", "reps": "50s Work / 15s Rest", "target": "Glutes & Hamstrings"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HIIT Library & Drills'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final item = exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primary.withValues(alpha: 0.2),
                child: Text('${index + 1}', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
              ),
              title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['reps']!),
              trailing: Chip(
                label: Text(item['target']!, style: const TextStyle(fontSize: 10)),
                backgroundColor: AppTheme.surface,
              ),
            ),
          );
        },
      ),
    );
  }
}
