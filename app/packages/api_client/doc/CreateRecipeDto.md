# api_client.model.CreateRecipeDto

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** |  | 
**altTitles** | **BuiltList&lt;String&gt;** |  | [optional] 
**country** | **String** |  | 
**region** | **String** |  | [optional] 
**city** | **String** |  | [optional] 
**cuisineTags** | **BuiltList&lt;String&gt;** |  | [optional] 
**isHidden** | **bool** |  | [optional] 
**prepTimeMinutes** | **num** |  | 
**cookTimeMinutes** | **num** |  | 
**totalTimeMinutes** | **num** |  | 
**difficulty** | **String** |  | 
**servingsBase** | **num** |  | [optional] 
**caloriesPerServing** | **num** |  | [optional] 
**culturalNote** | **String** |  | [optional] 
**ingredients** | [**BuiltList&lt;IngredientDto&gt;**](IngredientDto.md) |  | 
**steps** | [**BuiltList&lt;StepDto&gt;**](StepDto.md) |  | 
**unlockConditions** | [**BuiltList&lt;UnlockConditionDto&gt;**](UnlockConditionDto.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


