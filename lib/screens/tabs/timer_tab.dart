import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/storage_service.dart';

class TimerTab extends StatefulWidget {
  const TimerTab({super.key});

  @override
  State<TimerTab> createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  int _workSeconds = 30;
  int _restSeconds = 15;
  int _rounds = 8;
  int _currentRound = 1;
  int _secondsLeft = 30;
  bool _isWork = true;
  bool _isRunning = false;
  Timer? _timer;

  void _startTimer() {
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        setState(() => _secondsLeft--);
      } else {
        if (_isWork) {
          setState(() {
            _isWork = false;
            _secondsLeft = _restSeconds;
          });
        } else {
          if (_currentRound < _rounds) {
            setState(() {
              _currentRound++;
              _isWork = true;
              _secondsLeft = _workSeconds;
            });
          } else {
            _resetTimer();
            int totalWorkouts = StorageService.getInt('total_workouts') + 1;
            StorageService.setInt('total_workouts', totalWorkouts);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Great job! HIIT Workout Complete!')),
            );
          }
        }
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _currentRound = 1;
      _isWork = true;
      _secondsLeft = _workSeconds;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _isWork
        ? _secondsLeft / _workSeconds
        : _secondsLeft / _restSeconds;

    return Scaffold(
      appBar: AppBar(title: const Text('PulseFit HIIT Timer'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Round $_currentRound / $_rounds',
                style: const TextStyle(fontSize: 20, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 12),
              Text(
                _isWork ? '🔥 WORK' : '💤 REST',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _isWork ? AppTheme.primary : AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 32),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 14,
                      backgroundColor: AppTheme.card,
                      valueColor: AlwaysStoppedAnimation(
                        _isWork ? AppTheme.primary : AppTheme.secondary,
                      ),
                    ),
                  ),
                  Text(
                    '$_secondsLeft',
                    style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? AppTheme.secondary : AppTheme.primary,
                      foregroundColor: AppTheme.background,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(_isRunning ? 'Pause' : 'Start', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _resetTimer,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: const BorderSide(color: AppTheme.textSecondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Reset', style: TextStyle(color: AppTheme.textPrimary)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
