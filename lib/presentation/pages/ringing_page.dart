// lib/presentation/pages/ringing_page.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RingingPage extends StatefulWidget {
  const RingingPage({super.key});

  @override
  State<RingingPage> createState() => _RingingPageState();
}

class _RingingPageState extends State<RingingPage> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    _player = AudioPlayer();
    await _player.setAsset(
      'assets/sounds/quot-ticking-and-ringing-of-an-old-spring-alarm-clock-quot-338285.mp3',
    );
    await _player.setLoopMode(LoopMode.one);
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.alarm, size: 100, color: Colors.red),
            const SizedBox(height: 24),
            const Text(
              'Time to sleep!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _player.stop();
                Navigator.pop(context);
              },
              child: const Text('Stop Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
