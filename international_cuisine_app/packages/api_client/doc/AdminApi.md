# api_client.api.AdminApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminControllerCreateRecipe**](AdminApi.md#admincontrollercreaterecipe) | **POST** /api/v1/admin/recipes | [Admin] Create a new recipe with ingredients and steps
[**adminControllerDeleteRecipe**](AdminApi.md#admincontrollerdeleterecipe) | **DELETE** /api/v1/admin/recipes/{id} | [Admin] Delete a recipe
[**adminControllerGetAnalyticsOverview**](AdminApi.md#admincontrollergetanalyticsoverview) | **GET** /api/v1/admin/analytics/overview | [Admin] Get analytics dashboard overview
[**adminControllerListUsers**](AdminApi.md#admincontrollerlistusers) | **GET** /api/v1/admin/users | [Admin] List all users with stats
[**adminControllerSetUnlockConditions**](AdminApi.md#admincontrollersetunlockconditions) | **POST** /api/v1/admin/recipes/{id}/unlock-conditions | [Admin] Set unlock conditions for a hidden recipe
[**adminControllerUpdateRecipe**](AdminApi.md#admincontrollerupdaterecipe) | **PATCH** /api/v1/admin/recipes/{id} | [Admin] Update a recipe


# **adminControllerCreateRecipe**
> adminControllerCreateRecipe(createRecipeDto)

[Admin] Create a new recipe with ingredients and steps

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final CreateRecipeDto createRecipeDto = ; // CreateRecipeDto | 

try {
    api.adminControllerCreateRecipe(createRecipeDto);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerCreateRecipe: $e\n');
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

# **adminControllerDeleteRecipe**
> adminControllerDeleteRecipe(id)

[Admin] Delete a recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 

try {
    api.adminControllerDeleteRecipe(id);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerDeleteRecipe: $e\n');
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

# **adminControllerGetAnalyticsOverview**
> adminControllerGetAnalyticsOverview()

[Admin] Get analytics dashboard overview

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();

try {
    api.adminControllerGetAnalyticsOverview();
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerGetAnalyticsOverview: $e\n');
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

# **adminControllerListUsers**
> adminControllerListUsers(page, limit)

[Admin] List all users with stats

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final num page = 8.14; // num | 
final num limit = 8.14; // num | 

try {
    api.adminControllerListUsers(page, limit);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerListUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**|  | [optional] 
 **limit** | **num**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminControllerSetUnlockConditions**
> adminControllerSetUnlockConditions(id, requestBody)

[Admin] Set unlock conditions for a hidden recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final BuiltList<String> requestBody = ; // BuiltList<String> | 

try {
    api.adminControllerSetUnlockConditions(id, requestBody);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerSetUnlockConditions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **requestBody** | [**BuiltList&lt;String&gt;**](String.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminControllerUpdateRecipe**
> adminControllerUpdateRecipe(id, updateRecipeDto)

[Admin] Update a recipe

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAdminApi();
final String id = id_example; // String | 
final UpdateRecipeDto updateRecipeDto = ; // UpdateRecipeDto | 

try {
    api.adminControllerUpdateRecipe(id, updateRecipeDto);
} on DioException catch (e) {
    print('Exception when calling AdminApi->adminControllerUpdateRecipe: $e\n');
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

