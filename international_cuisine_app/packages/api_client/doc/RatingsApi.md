# api_client.api.RatingsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ratingsControllerCreate**](RatingsApi.md#ratingscontrollercreate) | **POST** /api/v1/recipes/{recipeId}/ratings | Rate and comment on a recipe (1-5 stars)
[**ratingsControllerFindByRecipe**](RatingsApi.md#ratingscontrollerfindbyrecipe) | **GET** /api/v1/recipes/{recipeId}/ratings | Get ratings for a recipe
[**ratingsControllerRemove**](RatingsApi.md#ratingscontrollerremove) | **DELETE** /api/v1/recipes/{recipeId}/ratings/{id} | Delete own rating
[**ratingsControllerUpdate**](RatingsApi.md#ratingscontrollerupdate) | **PATCH** /api/v1/recipes/{recipeId}/ratings/{id} | Update own rating


# **ratingsControllerCreate**
> ratingsControllerCreate(recipeId, createRatingDto)

Rate and comment on a recipe (1-5 stars)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String recipeId = recipeId_example; // String | 
final CreateRatingDto createRatingDto = ; // CreateRatingDto | 

try {
    api.ratingsControllerCreate(recipeId, createRatingDto);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipeId** | **String**|  | 
 **createRatingDto** | [**CreateRatingDto**](CreateRatingDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratingsControllerFindByRecipe**
> ratingsControllerFindByRecipe(recipeId)

Get ratings for a recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String recipeId = recipeId_example; // String | 

try {
    api.ratingsControllerFindByRecipe(recipeId);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerFindByRecipe: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipeId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratingsControllerRemove**
> ratingsControllerRemove(recipeId, id)

Delete own rating

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String recipeId = recipeId_example; // String | 
final String id = id_example; // String | 

try {
    api.ratingsControllerRemove(recipeId, id);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipeId** | **String**|  | 
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **ratingsControllerUpdate**
> ratingsControllerUpdate(recipeId, id, updateRatingDto)

Update own rating

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getRatingsApi();
final String recipeId = recipeId_example; // String | 
final String id = id_example; // String | 
final UpdateRatingDto updateRatingDto = ; // UpdateRatingDto | 

try {
    api.ratingsControllerUpdate(recipeId, id, updateRatingDto);
} on DioException catch (e) {
    print('Exception when calling RatingsApi->ratingsControllerUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **recipeId** | **String**|  | 
 **id** | **String**|  | 
 **updateRatingDto** | [**UpdateRatingDto**](UpdateRatingDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

