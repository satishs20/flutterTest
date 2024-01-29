// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailEntity _$UserDetailEntityFromJson(Map<String, dynamic> json) =>
    UserDetailEntity(
      json['kind'] as String?,
      json['idToken'] as String?,
      json['displayName'] as String?,
      json['email'] as String?,
      json['refreshToken'] as String?,
      json['expiresIn'] as String?,
      json['localId'] as String?,
    );

Map<String, dynamic> _$UserDetailEntityToJson(UserDetailEntity instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'idToken': instance.idToken,
      'displayName': instance.displayName,
      'email': instance.email,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'localId': instance.localId,
    };
