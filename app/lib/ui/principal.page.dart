import 'package:app/connections/ia.connections.dart';

import '../helpers/exports.dart';
import "package:speech_to_text/speech_to_text.dart" as stt;

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  var flutterTts = FlutterTts();
  bool escuchando = false;
  @override
  void initState() {
    _speackInit("Bienvenido");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              localStorage!.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "CURSO de AI",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var text = await _listen();
          await _speack(text);
        },
        child: Icon(escuchando?Icons.speaker_group_outlined:Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Fonles AI Assistant",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      )),
    );
  }

  _listen() async {
    setState(() {
      escuchando = true;
    });
    stt.SpeechToText speech = stt.SpeechToText();
    bool available = await speech.initialize(
      onStatus: (status) {
        print(status);
      },
      onError: (errorNotification) {
        print(errorNotification);
      },
    );

    if (available) {
      speech.listen(
        onResult: (result) {
          print(result);
        },
      );
    } else {
      print("el usuario nego el reconocimiento");
    }

    await Future.delayed(Duration(seconds: 5), () async {
      await speech.stop();
    });
    return speech.lastRecognizedWords;
  }

  _speack(text) async {
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
        ],
        IosTextToSpeechAudioMode.defaultMode);
    var response =
        await IaConnections().generateIA("asst_Sb6YxLgaSOQaHSHOyCbjkOD4", text);
    print(response);
    await flutterTts.speak(response);
    setState(() {
      escuchando = false;
    });
  }

  _speackInit(text) async {
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        ],
        IosTextToSpeechAudioMode.defaultMode);

    await flutterTts.speak(text);
  }
}
