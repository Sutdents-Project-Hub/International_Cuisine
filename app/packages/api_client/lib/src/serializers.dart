//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api_client/src/date_serializer.dart';
import 'package:api_client/src/model/date.dart';

import 'package:api_client/src/model/create_event_dto.dart';
import 'package:api_client/src/model/create_favorite_dto.dart';
import 'package:api_client/src/model/create_rating_dto.dart';
import 'package:api_client/src/model/create_recipe_dto.dart';
import 'package:api_client/src/model/create_shopping_list_dto.dart';
import 'package:api_client/src/model/ingredient_dto.dart';
import 'package:api_client/src/model/login_dto.dart';
import 'package:api_client/src/model/recipe_serving_pair.dart';
import 'package:api_client/src/model/register_dto.dart';
import 'package:api_client/src/model/step_dto.dart';
import 'package:api_client/src/model/unlock_condition_dto.dart';
import 'package:api_client/src/model/update_profile_dto.dart';
import 'package:api_client/src/model/update_rating_dto.dart';
import 'package:api_client/src/model/update_recipe_dto.dart';

part 'serializers.g.dart';

@SerializersFor([
  CreateEventDto,
  CreateFavoriteDto,
  CreateRatingDto,
  CreateRecipeDto,
  CreateShoppingListDto,
  IngredientDto,
  LoginDto,
  RecipeServingPair,
  RegisterDto,
  StepDto,
  UnlockConditionDto,
  UpdateProfileDto,
  UpdateRatingDto,
  UpdateRecipeDto,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
