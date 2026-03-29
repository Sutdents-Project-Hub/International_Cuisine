# api_client.api.ShoppingListsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**shoppingListsControllerCreate**](ShoppingListsApi.md#shoppinglistscontrollercreate) | **POST** /api/v1/shopping-lists | Create shopping list from recipe IDs with servings (auto-merges ingredients)
[**shoppingListsControllerExportCsv**](ShoppingListsApi.md#shoppinglistscontrollerexportcsv) | **GET** /api/v1/shopping-lists/{id}/export | Export shopping list as CSV
[**shoppingListsControllerFindAll**](ShoppingListsApi.md#shoppinglistscontrollerfindall) | **GET** /api/v1/shopping-lists | List all shopping lists
[**shoppingListsControllerFindOne**](ShoppingListsApi.md#shoppinglistscontrollerfindone) | **GET** /api/v1/shopping-lists/{id} | Get shopping list detail
[**shoppingListsControllerRemove**](ShoppingListsApi.md#shoppinglistscontrollerremove) | **DELETE** /api/v1/shopping-lists/{id} | Delete a shopping list
[**shoppingListsControllerToggleItem**](ShoppingListsApi.md#shoppinglistscontrollertoggleitem) | **PATCH** /api/v1/shopping-lists/{id}/items/{itemId}/toggle | Toggle item checked status


# **shoppingListsControllerCreate**
> shoppingListsControllerCreate(createShoppingListDto)

Create shopping list from recipe IDs with servings (auto-merges ingredients)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();
final CreateShoppingListDto createShoppingListDto = ; // CreateShoppingListDto | 

try {
    api.shoppingListsControllerCreate(createShoppingListDto);
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createShoppingListDto** | [**CreateShoppingListDto**](CreateShoppingListDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **shoppingListsControllerExportCsv**
> shoppingListsControllerExportCsv(id)

Export shopping list as CSV

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();
final String id = id_example; // String | 

try {
    api.shoppingListsControllerExportCsv(id);
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerExportCsv: $e\n');
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

# **shoppingListsControllerFindAll**
> shoppingListsControllerFindAll()

List all shopping lists

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();

try {
    api.shoppingListsControllerFindAll();
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerFindAll: $e\n');
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

# **shoppingListsControllerFindOne**
> shoppingListsControllerFindOne(id)

Get shopping list detail

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();
final String id = id_example; // String | 

try {
    api.shoppingListsControllerFindOne(id);
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerFindOne: $e\n');
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

# **shoppingListsControllerRemove**
> shoppingListsControllerRemove(id)

Delete a shopping list

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();
final String id = id_example; // String | 

try {
    api.shoppingListsControllerRemove(id);
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerRemove: $e\n');
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

# **shoppingListsControllerToggleItem**
> shoppingListsControllerToggleItem(id, itemId)

Toggle item checked status

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getShoppingListsApi();
final String id = id_example; // String | 
final String itemId = itemId_example; // String | 

try {
    api.shoppingListsControllerToggleItem(id, itemId);
} on DioException catch (e) {
    print('Exception when calling ShoppingListsApi->shoppingListsControllerToggleItem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **itemId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

