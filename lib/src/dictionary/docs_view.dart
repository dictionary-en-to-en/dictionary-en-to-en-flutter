import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api.dart';
import '../audio/audio_controller.dart';
import 'meaning_view.dart';

class DocsView extends StatelessWidget {
  final Docs docs;

  const DocsView({Key? key, required this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    docs.word,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  for (final phonetic in docs.phonetics ?? [])
                    if (phonetic.text != "")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              phonetic.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(fontStyle: FontStyle.italic),
                            ),
                            if (phonetic.audio != null)
                              IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed:
                                    context.watch<AudioController>().readyToPlay
                                        ? () {
                                            context
                                                .read<AudioController>()
                                                .play(phonetic.audio);
                                          }
                                        : null,
                              ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
            for (final meaning in docs.meanings ?? [])
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MeaningView(
                  meaning: meaning,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
