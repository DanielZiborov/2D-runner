import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  double _soundValue = 0.5;
  double _musicValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ползунок для звука
            Row(
              children: [
                _soundValue != 0
                    ? const Icon(Icons.volume_up, size: 32)
                    : const Icon(Icons.volume_off, size: 32),
                Expanded(
                  child: Slider(
                    value: _soundValue,
                    onChanged: (value) {
                      setState(() {
                        _soundValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${(_soundValue * 100).round()}%',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Ползунок для музыки
            Row(
              children: [
                _musicValue != 0
                    ? const Icon(Icons.music_note, size: 32)
                    : const Icon(Icons.music_off, size: 32),
                Expanded(
                  child: Slider(
                    value: _musicValue,
                    onChanged: (value) {
                      setState(() {
                        _musicValue = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    '${(_musicValue * 100).round()}%',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
