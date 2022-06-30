import 'package:dictionary_en_to_en/src/dictionary/docs_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../settings/settings_view.dart';
import 'dictionary_controller.dart';

/// Displays a list of SampleItems.
class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DictionaryController>();
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchPlaceholder,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                controller.search(value);
              },
            ),
          ),
          if (controller.error != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 64.0,
                      color: Theme.of(context).disabledColor,
                    ),
                    const SizedBox(height: 12.0),
                    Text(AppLocalizations.of(context)!.errorTitle),
                    const SizedBox(height: 4.0),
                    Text(controller.error!, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // Foreground color
                        onPrimary: Theme.of(context).colorScheme.onPrimary,
                        // Background color
                        primary: Theme.of(context).colorScheme.primary,
                      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                      onPressed: controller.retry,
                      child: Text(AppLocalizations.of(context)!.retryButton),
                    ),
                  ],
                ),
              ),
            )
          else if (controller.data == null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: brightness == Brightness.light
                      ? Colors.grey.shade300
                      : Colors.grey.shade900,
                  highlightColor: brightness == Brightness.light
                      ? Colors.grey.shade100
                      : Colors.grey.shade600,
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 4.0,
                        bottom: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.0,
                            height: 20.0,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            width: 80.0,
                            height: 10.0,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (controller.data!.isEmpty && controller.query.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: 64.0,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 12.0),
                  Text(AppLocalizations.of(context)!.welcomeMessage),
                ],
              ),
            )
          else if (controller.data!.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64.0,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 12.0),
                  Text(AppLocalizations.of(context)!.noResultsTitle),
                  const SizedBox(height: 12.0),
                  Text(
                    AppLocalizations.of(context)!
                        .noResultsMessage(controller.query),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'sampleItemListView',
                itemCount: controller.data!.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  if (controller.data == null) {
                    return const CircularProgressIndicator();
                  }
                  return DocsView(
                    docs: controller.data![index],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
