# api_client.api.FavoritesApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**favoritesControllerCreate**](FavoritesApi.md#favoritescontrollercreate) | **POST** /api/v1/favorites | Add a recipe to favorites
[**favoritesControllerFindAll**](FavoritesApi.md#favoritescontrollerfindall) | **GET** /api/v1/favorites | List user favorites, optionally by category
[**favoritesControllerGetCategories**](FavoritesApi.md#favoritescontrollergetcategories) | **GET** /api/v1/favorites/categories | List custom favorite categories
[**favoritesControllerRemove**](FavoritesApi.md#favoritescontrollerremove) | **DELETE** /api/v1/favorites/{id} | Remove a recipe from favorites


# **favoritesControllerCreate**
> favoritesControllerCreate(createFavoriteDto)

Add a recipe to favorites

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavoritesApi();
final CreateFavoriteDto createFavoriteDto = ; // CreateFavoriteDto | 

try {
    api.favoritesControllerCreate(createFavoriteDto);
} on DioException catch (e) {
    print('Exception when calling FavoritesApi->favoritesControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createFavoriteDto** | [**CreateFavoriteDto**](CreateFavoriteDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **favoritesControllerFindAll**
> favoritesControllerFindAll(category)

List user favorites, optionally by category

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavoritesApi();
final String category = category_example; // String | 

try {
    api.favoritesControllerFindAll(category);
} on DioException catch (e) {
    print('Exception when calling FavoritesApi->favoritesControllerFindAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **favoritesControllerGetCategories**
> favoritesControllerGetCategories()

List custom favorite categories

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavoritesApi();

try {
    api.favoritesControllerGetCategories();
} on DioException catch (e) {
    print('Exception when calling FavoritesApi->favoritesControllerGetCategories: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **favoritesControllerRemove**
> favoritesControllerRemove(id)

Remove a recipe from favorites

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFavoritesApi();
final String id = id_example; // String | 

try {
    api.favoritesControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling FavoritesApi->favoritesControllerRemove: $e\n');
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

