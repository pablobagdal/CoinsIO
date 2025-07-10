import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_brief.freezed.dart';
part 'account_brief.g.dart';

@freezed
abstract class AccountBrief with _$AccountBrief {
  const factory AccountBrief({
    required final int id,
    required final String name,
    required final String balance,
    required final String currency,
  }) = _AccountBrief;

  factory AccountBrief.fromJson(final Map<String, dynamic> json) =>
      _$AccountBriefFromJson(json);
}
