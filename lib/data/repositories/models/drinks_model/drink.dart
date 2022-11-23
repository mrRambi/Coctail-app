// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
class Drink with _$Drink {
  const Drink._();

  factory Drink({
    String? idDrink,
    String? strDrink,
    String? strDrinkAlternate,
    String? strTags,
    String? strVideo,
    String? strCategory,
    @JsonKey(name: 'strIBA') String? strIba,
    String? strAlcoholic,
    String? strGlass,
    String? strInstructions,
    @JsonKey(name: 'strInstructionsES') String? strInstructionsEs,
    @JsonKey(name: 'strInstructionsDE') String? strInstructionsDe,
    @JsonKey(name: 'strInstructionsFR') String? strInstructionsFr,
    @JsonKey(name: 'strInstructionsIT') String? strInstructionsIt,
    @JsonKey(name: 'strInstructionsZH-HANS') String? strInstructionsZhHans,
    @JsonKey(name: 'strInstructionsZH-HANT') String? strInstructionsZhHant,
    String? strDrinkThumb,
    String? strIngredient1,
    String? strIngredient2,
    String? strIngredient3,
    String? strIngredient4,
    String? strIngredient5,
    String? strIngredient6,
    String? strIngredient7,
    String? strIngredient8,
    String? strIngredient9,
    String? strIngredient10,
    String? strIngredient11,
    String? strIngredient12,
    String? strIngredient13,
    String? strIngredient14,
    String? strIngredient15,
    String? strMeasure1,
    String? strMeasure2,
    String? strMeasure3,
    String? strMeasure4,
    String? strMeasure5,
    String? strMeasure6,
    String? strMeasure7,
    String? strMeasure8,
    String? strMeasure9,
    String? strMeasure10,
    String? strMeasure11,
    String? strMeasure12,
    String? strMeasure13,
    String? strMeasure14,
    String? strMeasure15,
    String? strImageSource,
    String? strImageAttribution,
    String? strCreativeCommonsConfirmed,
    String? dateModified,
  }) = _Drink;
  @override
  String toString();

  List<String?> ingriedientProperties() => [
        strIngredient1,
        strIngredient2,
        strIngredient3,
        strIngredient4,
        strIngredient5,
        strIngredient6,
        strIngredient7,
        strIngredient8,
        strIngredient9,
        strIngredient10,
        strIngredient11,
        strIngredient12,
        strIngredient13,
        strIngredient14,
        strIngredient15,
      ];

  List<String?> measureProperties() => [
        strMeasure1,
        strMeasure2,
        strMeasure3,
        strMeasure4,
        strMeasure5,
        strMeasure6,
        strMeasure7,
        strMeasure8,
        strMeasure9,
        strMeasure10,
        strMeasure11,
        strMeasure12,
        strMeasure13,
        strMeasure14,
        strMeasure15
      ];

  List<String?> idOfDrink() => [idDrink];

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
}
