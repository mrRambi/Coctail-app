import 'package:freezed_annotation/freezed_annotation.dart';

import 'drink.dart';

part 'drinks_data.freezed.dart';
part 'drinks_data.g.dart';

@freezed
class DrinksData with _$DrinksData {
  factory DrinksData({
    List<Drink>? drinks,
  }) = _DrinksData;

  factory DrinksData.fromJson(Map<String, dynamic> json) =>
      _$DrinksDataFromJson(json);
}
