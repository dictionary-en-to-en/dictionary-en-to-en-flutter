import 'package:flutter/material.dart';

import '../api/api.dart';
import 'definition_view.dart';

class MeaningView extends StatelessWidget {
  final Meanings meaning;

  const MeaningView({Key? key, required this.meaning}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          meaning.partOfSpeech,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontStyle: FontStyle.italic,
              ),
        ),
        const SizedBox(height: 8.0),
        for (final definition in meaning.definitions ?? [])
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefinitionView(
              definition: definition,
            ),
          ),
      ],
    );
  }
}
