import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Definitions {
  final String definition;
  final String example;

  const Definitions({
    required this.definition,
    required this.example,
  });

  factory Definitions.fromJson(Map<String, dynamic> json) =>
      _$DefinitionsFromJson(json);
}

@JsonSerializable()
class Meanings {
  final String partOfSpeech;
  final List<Definitions>? definitions;

  const Meanings({
    required this.partOfSpeech,
    required this.definitions,
  });

  factory Meanings.fromJson(Map<String, dynamic> json) =>
      _$MeaningsFromJson(json);
}

@JsonSerializable()
class Phonetics {
  final String text;
  final String? audio;

  const Phonetics({
    required this.text,
    required this.audio,
  });

  factory Phonetics.fromJson(Map<String, dynamic> json) =>
      _$PhoneticsFromJson(json);
}

@JsonSerializable()
class Docs {
  final String word;
  final List<Phonetics>? phonetics;
  final List<Meanings>? meanings;

  const Docs({
    required this.word,
    required this.phonetics,
    required this.meanings,
  });

  factory Docs.fromJson(Map<String, dynamic> json) => _$DocsFromJson(json);
}

@JsonSerializable()
class SearchResponse {
  final bool status;
  final List<Docs>? data;
  final dynamic error;

  const SearchResponse({
    required this.status,
    required this.data,
    required this.error,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@JsonSerializable()
class SearchRequestData {
  final String word;

  const SearchRequestData({
    required this.word,
  });

  factory SearchRequestData.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRequestDataToJson(this);
}
