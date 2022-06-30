import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../api/api.dart';

class DefinitionView extends StatelessWidget {
  final Definitions definition;

  const DefinitionView({Key? key, required this.definition}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          definition.definition,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.justify,
        ),
        if (definition.example != "")
          Text(
            AppLocalizations.of(context)!.exampleTitle(definition.example),
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontStyle: FontStyle.italic),
          ),
      ],
    );
  }
}
