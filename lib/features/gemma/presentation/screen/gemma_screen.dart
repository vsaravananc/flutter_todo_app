import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaScreenAI extends StatefulWidget {
  const GemmaScreenAI({super.key});

  @override
  State<GemmaScreenAI> createState() => _GemmaScreenAIState();
}

class _GemmaScreenAIState extends State<GemmaScreenAI> {
  int _downloadProgress = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const modelUrl =
          'https://huggingface.co/google/gemma-3n-E2B-it-litert-preview/resolve/main/gemma-3n-E2B-it-int4.task';
      await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
          .fromNetwork(modelUrl, token: dotenv.get('HUGGINGFACETOKEN'))
          .withProgress((p) => setState(() => _downloadProgress = p))
          .install();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("download progress : $_downloadProgress")),
    );
  }
}
