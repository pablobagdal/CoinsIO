import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_brief_model.freezed.dart';
part 'account_brief_model.g.dart';

@freezed
abstract class AccountBriefModel with _$AccountBriefModel {
  const factory AccountBriefModel({
    required final int id,
    required final String name,
    required final String balance,
    required final String currency,
  }) = _AccountBriefModel;

  factory AccountBriefModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountBriefModelFromJson(json);
}
