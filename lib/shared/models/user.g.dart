// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['user_id'] as int,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      name: json['username'] as String?,
      phoneNumber: json['phone'] as String?,
      role: json['role'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'user_id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'username': instance.name,
      'phone': instance.phoneNumber,
      'role': instance.role,
    };
