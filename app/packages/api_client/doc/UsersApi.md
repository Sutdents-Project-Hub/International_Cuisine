# api_client.api.UsersApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersControllerGetAchievements**](UsersApi.md#userscontrollergetachievements) | **GET** /api/v1/users/achievements | Get user achievements (badges, unlocked recipes)
[**usersControllerGetLevelInfo**](UsersApi.md#userscontrollergetlevelinfo) | **GET** /api/v1/users/level | Get user level info and XP progress
[**usersControllerUpdateProfile**](UsersApi.md#userscontrollerupdateprofile) | **PATCH** /api/v1/users/profile | Update user profile


# **usersControllerGetAchievements**
> usersControllerGetAchievements()

Get user achievements (badges, unlocked recipes)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUsersApi();

try {
    api.usersControllerGetAchievements();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetAchievements: $e\n');
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

# **usersControllerGetLevelInfo**
> usersControllerGetLevelInfo()

Get user level info and XP progress

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUsersApi();

try {
    api.usersControllerGetLevelInfo();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetLevelInfo: $e\n');
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

# **usersControllerUpdateProfile**
> usersControllerUpdateProfile(updateProfileDto)

Update user profile

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getUsersApi();
final UpdateProfileDto updateProfileDto = ; // UpdateProfileDto | 

try {
    api.usersControllerUpdateProfile(updateProfileDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerUpdateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileDto** | [**UpdateProfileDto**](UpdateProfileDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

