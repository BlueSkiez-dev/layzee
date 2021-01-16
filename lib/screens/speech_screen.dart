import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:lazy_notes/palette.dart';
import 'package:highlight_text/highlight_text.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onStatus: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(
            () {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            },
          ),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // final Map<String, HighlightedWord> _highlights = {
  //   'flutter': HighlightedWord(
  //     onTap: () => print('flutter'),
  //     textStyle: const TextStyle(
  //       color: Colors.blue,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'voice': HighlightedWord(
  //     onTap: () => print('voice'),
  //     textStyle: const TextStyle(
  //       color: Colors.green,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'subscribe': HighlightedWord(
  //     onTap: () => print('subscribe'),
  //     textStyle: const TextStyle(
  //       color: Colors.red,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'like': HighlightedWord(
  //     onTap: () => print('like'),
  //     textStyle: const TextStyle(
  //       color: Colors.blueAccent,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   'comment': HighlightedWord(
  //     onTap: () => print('comment'),
  //     textStyle: const TextStyle(
  //       color: Colors.green,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/history.png'),
                Image.asset('assets/images/settings.png'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Palette.lightGrey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('blah'),
                      Text('blah'),
                      Text('blah'),
                      Text('blah'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Card(
                      elevation: 6,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 150),
                          // ignore: missing_required_param
                          child: TextHighlight(
                            text: _text,
                            // words: _highlights,
                            // textStyle: ,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Colors.red,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
}
