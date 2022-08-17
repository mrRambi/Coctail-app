import 'package:freezed_annotation/freezed_annotation.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
class Drink with _$Drink {
  factory Drink({
    String? idDrink,
    String? strDrink,
    dynamic strDrinkAlternate,
    dynamic strTags,
    dynamic strVideo,
    String? strCategory,
    @JsonKey(name: 'strIBA') dynamic strIba,
    String? strAlcoholic,
    String? strGlass,
    String? strInstructions,
    @JsonKey(name: 'strInstructionsES') dynamic strInstructionsEs,
    @JsonKey(name: 'strInstructionsDE') String? strInstructionsDe,
    @JsonKey(name: 'strInstructionsFR') dynamic strInstructionsFr,
    @JsonKey(name: 'strInstructionsIT') String? strInstructionsIt,
    @JsonKey(name: 'strInstructionsZH-HANS') dynamic strInstructionsZhHans,
    @JsonKey(name: 'strInstructionsZH-HANT') dynamic strInstructionsZhHant,
    String? strDrinkThumb,
    String? strIngredient1,
    String? strIngredient2,
    String? strIngredient3,
    String? strIngredient4,
    dynamic strIngredient5,
    dynamic strIngredient6,
    dynamic strIngredient7,
    dynamic strIngredient8,
    dynamic strIngredient9,
    dynamic strIngredient10,
    dynamic strIngredient11,
    dynamic strIngredient12,
    dynamic strIngredient13,
    dynamic strIngredient14,
    dynamic strIngredient15,
    String? strMeasure1,
    String? strMeasure2,
    String? strMeasure3,
    dynamic strMeasure4,
    dynamic strMeasure5,
    dynamic strMeasure6,
    dynamic strMeasure7,
    dynamic strMeasure8,
    dynamic strMeasure9,
    dynamic strMeasure10,
    dynamic strMeasure11,
    dynamic strMeasure12,
    dynamic strMeasure13,
    dynamic strMeasure14,
    dynamic strMeasure15,
    dynamic strImageSource,
    dynamic strImageAttribution,
    String? strCreativeCommonsConfirmed,
    String? dateModified,
  }) = _Drink;

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
}
