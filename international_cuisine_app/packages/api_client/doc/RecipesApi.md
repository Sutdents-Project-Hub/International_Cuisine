# api_client.api.RecipesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**recipesControllerComplete**](RecipesApi.md#recipescontrollercomplete) | **POST** /api/v1/recipes/{id}/complete | Mark recipe as completed (earn XP, check level up and unlocks)
[**recipesControllerCreate**](RecipesApi.md#recipescontrollercreate) | **POST** /api/v1/recipes | Create a new recipe
[**recipesControllerFindAll**](RecipesApi.md#recipescontrollerfindall) | **GET** /api/v1/recipes | List recipes with search and filters
[**recipesControllerFindOne**](RecipesApi.md#recipescontrollerfindone) | **GET** /api/v1/recipes/{id} | Get recipe detail (auto-increments view count)
[**recipesControllerGetCountries**](RecipesApi.md#recipescontrollergetcountries) | **GET** /api/v1/recipes/countries | Get available countries grouped by continent
[**recipesControllerGetScaled**](RecipesApi.md#recipescontrollergetscaled) | **GET** /api/v1/recipes/{id}/scale | Get recipe with scaled servings
[**recipesControllerRemove**](RecipesApi.md#recipescontrollerremove) | **DELETE** /api/v1/recipes/{id} | Delete your own recipe
[**recipesControllerUnlock**](RecipesApi.md#recipescontrollerunlock) | **POST** /api/v1/recipes/{id}/unlock | Attempt to unlock a hidden recipe
[**recipesControllerUpdate**](RecipesApi.md#recipescontrollerupdate) | **PATCH** /api/v1/recipes/{id} | Update your own recipe


# **recipesControllerComplete**
> recipesControllerComplete(id)

Mark recipe as completed (earn XP, check level up and unlocks)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 

try {
    api.recipesControllerComplete(id);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerComplete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerCreate**
> recipesControllerCreate(createRecipeDto)

Create a new recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final CreateRecipeDto createRecipeDto = ; // CreateRecipeDto | 

try {
    api.recipesControllerCreate(createRecipeDto);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRecipeDto** | [**CreateRecipeDto**](CreateRecipeDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerFindAll**
> recipesControllerFindAll(search, country, continent, diet, difficulty, maxTime, maxIngredients, maxCalories, cookingMethod, showHidden, page, limit)

List recipes with search and filters

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String search = sushi; // String | 
final String country = Japan; // String | 
final String continent = Asia; // String | 
final String diet = vegetarian; // String | 
final String difficulty = difficulty_example; // String | 
final num maxTime = 30; // num | 
final num maxIngredients = 6; // num | 
final num maxCalories = 500; // num | 
final String cookingMethod = fry; // String | 
final bool showHidden = false; // bool | 
final num page = 1; // num | 
final num limit = 20; // num | 

try {
    api.recipesControllerFindAll(search, country, continent, diet, difficulty, maxTime, maxIngredients, maxCalories, cookingMethod, showHidden, page, limit);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **search** | **String**|  | [optional] 
 **country** | **String**|  | [optional] 
 **continent** | **String**|  | [optional] 
 **diet** | **String**|  | [optional] 
 **difficulty** | **String**|  | [optional] 
 **maxTime** | **num**|  | [optional] 
 **maxIngredients** | **num**|  | [optional] 
 **maxCalories** | **num**|  | [optional] 
 **cookingMethod** | **String**|  | [optional] 
 **showHidden** | **bool**|  | [optional] 
 **page** | **num**|  | [optional] 
 **limit** | **num**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerFindOne**
> recipesControllerFindOne(id)

Get recipe detail (auto-increments view count)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 

try {
    api.recipesControllerFindOne(id);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerGetCountries**
> recipesControllerGetCountries()

Get available countries grouped by continent

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();

try {
    api.recipesControllerGetCountries();
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerGetCountries: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerGetScaled**
> recipesControllerGetScaled(id, servings)

Get recipe with scaled servings

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 
final num servings = 4; // num | 

try {
    api.recipesControllerGetScaled(id, servings);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerGetScaled: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **servings** | **num**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerRemove**
> recipesControllerRemove(id)

Delete your own recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 

try {
    api.recipesControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerUnlock**
> recipesControllerUnlock(id)

Attempt to unlock a hidden recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 

try {
    api.recipesControllerUnlock(id);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerUnlock: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **recipesControllerUpdate**
> recipesControllerUpdate(id, updateRecipeDto)

Update your own recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRecipesApi();
final String id = id_example; // String | 
final UpdateRecipeDto updateRecipeDto = ; // UpdateRecipeDto | 

try {
    api.recipesControllerUpdate(id, updateRecipeDto);
} on DioException catch (e) {
    print('Exception when calling RecipesApi->recipesControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateRecipeDto** | [**UpdateRecipeDto**](UpdateRecipeDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

