# api_client.api.AnalyticsApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**analyticsControllerGetStats**](AnalyticsApi.md#analyticscontrollergetstats) | **GET** /api/v1/analytics/stats | Get user analytics stats
[**analyticsControllerTrackEvent**](AnalyticsApi.md#analyticscontrollertrackevent) | **POST** /api/v1/analytics/events | Track an analytics event (view, start, complete, favorite)


# **analyticsControllerGetStats**
> analyticsControllerGetStats()

Get user analytics stats

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnalyticsApi();

try {
    api.analyticsControllerGetStats();
} on DioException catch (e) {
    print('Exception when calling AnalyticsApi->analyticsControllerGetStats: $e\n');
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

# **analyticsControllerTrackEvent**
> analyticsControllerTrackEvent(createEventDto)

Track an analytics event (view, start, complete, favorite)

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getAnalyticsApi();
final CreateEventDto createEventDto = ; // CreateEventDto | 

try {
    api.analyticsControllerTrackEvent(createEventDto);
} on DioException catch (e) {
    print('Exception when calling AnalyticsApi->analyticsControllerTrackEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createEventDto** | [**CreateEventDto**](CreateEventDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

