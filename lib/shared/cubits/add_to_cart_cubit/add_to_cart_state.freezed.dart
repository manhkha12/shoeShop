// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddToCartState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get addToCartSuccess => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  String? get variantId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddToCartStateCopyWith<AddToCartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddToCartStateCopyWith<$Res> {
  factory $AddToCartStateCopyWith(
          AddToCartState value, $Res Function(AddToCartState) then) =
      _$AddToCartStateCopyWithImpl<$Res, AddToCartState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool addToCartSuccess,
      String? userId,
      String? quantity,
      String? variantId});
}

/// @nodoc
class _$AddToCartStateCopyWithImpl<$Res, $Val extends AddToCartState>
    implements $AddToCartStateCopyWith<$Res> {
  _$AddToCartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addToCartSuccess = null,
    Object? userId = freezed,
    Object? quantity = freezed,
    Object? variantId = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addToCartSuccess: null == addToCartSuccess
          ? _value.addToCartSuccess
          : addToCartSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddToCartStateImplCopyWith<$Res>
    implements $AddToCartStateCopyWith<$Res> {
  factory _$$AddToCartStateImplCopyWith(_$AddToCartStateImpl value,
          $Res Function(_$AddToCartStateImpl) then) =
      __$$AddToCartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool addToCartSuccess,
      String? userId,
      String? quantity,
      String? variantId});
}

/// @nodoc
class __$$AddToCartStateImplCopyWithImpl<$Res>
    extends _$AddToCartStateCopyWithImpl<$Res, _$AddToCartStateImpl>
    implements _$$AddToCartStateImplCopyWith<$Res> {
  __$$AddToCartStateImplCopyWithImpl(
      _$AddToCartStateImpl _value, $Res Function(_$AddToCartStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? addToCartSuccess = null,
    Object? userId = freezed,
    Object? quantity = freezed,
    Object? variantId = freezed,
  }) {
    return _then(_$AddToCartStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      addToCartSuccess: null == addToCartSuccess
          ? _value.addToCartSuccess
          : addToCartSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AddToCartStateImpl extends _AddToCartState {
  _$AddToCartStateImpl(
      {this.isLoading = false,
      this.addToCartSuccess = false,
      this.userId,
      this.quantity,
      this.variantId})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool addToCartSuccess;
  @override
  final String? userId;
  @override
  final String? quantity;
  @override
  final String? variantId;

  @override
  String toString() {
    return 'AddToCartState(isLoading: $isLoading, addToCartSuccess: $addToCartSuccess, userId: $userId, quantity: $quantity, variantId: $variantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToCartStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.addToCartSuccess, addToCartSuccess) ||
                other.addToCartSuccess == addToCartSuccess) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, addToCartSuccess, userId, quantity, variantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToCartStateImplCopyWith<_$AddToCartStateImpl> get copyWith =>
      __$$AddToCartStateImplCopyWithImpl<_$AddToCartStateImpl>(
          this, _$identity);
}

abstract class _AddToCartState extends AddToCartState {
  factory _AddToCartState(
      {final bool isLoading,
      final bool addToCartSuccess,
      final String? userId,
      final String? quantity,
      final String? variantId}) = _$AddToCartStateImpl;
  _AddToCartState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get addToCartSuccess;
  @override
  String? get userId;
  @override
  String? get quantity;
  @override
  String? get variantId;
  @override
  @JsonKey(ignore: true)
  _$$AddToCartStateImplCopyWith<_$AddToCartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
