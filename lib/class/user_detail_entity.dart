import 'package:json_annotation/json_annotation.dart';

part 'user_detail_entity.g.dart';

@JsonSerializable()
class UserDetailEntity {
  UserDetailEntity(this.kind, this.idToken, this.displayName, this.email, this.refreshToken, this.expiresIn, this.localId);

  factory UserDetailEntity.fromJson(Map<String, dynamic> json) => _$UserDetailEntityFromJson(json);
  String? kind;
  String? idToken;
  String? displayName;
  String? email;
  String? refreshToken;
  String? expiresIn;
  String? localId;

  Map<String, dynamic> toJson() => _$UserDetailEntityToJson(this);
}
