<a id="content"></a>

<a id="enabling-cors-in-a-lambda-proxy"></a>

# Enabling CORS in a Lambda Proxy

<a id="outline-container-the-problem"></a>

<a id="the-problem"></a>

## The Problem

<a id="text-the-problem"></a>

Preflight `OPTIONS` requests are blocked by the `CORS` policy when using Cognito to authorize requests to an API Gateway HTTP direct `$default`.

<a id="outline-container-the-solution"></a>

<a id="the-solution"></a>

## The Solution

<a id="text-the-solution"></a>

- Go to the AWS [API Gateway console](https://console.aws.amazon.com/apigateway/home).
- Select your HTTP direct API.
- Attach your authorizer to your `$default` route and follow the steps to set it up.
- Click "Routes".
- Click "Create".
- Create a new `OPTIONS` route with a path of `/{proxy+}`.
- Attach your HTTP Direct (port 8184) integration to this path.
- Click "CORS".
- Click "Configure".
- Configure as required by your application.

<a id="outline-container-adding-cors-headers-in-your-app"></a>

<a id="adding-cors-headers-in-your-app"></a>

### Adding CORS Headers in Your App

<a id="text-adding-cors-headers-in-your-app"></a>

With the above change, requests will now be passed to your application which will be responsible for adding the desired CORS headers. A maximally permissive set of headers is provided here as a reference. You may adjust based on your specific needs:

``` clojure
(def cors-headers {"Access-Control-Allow-Origin" "*"
                   "Access-Control-Allow-Methods" "GET, PUT, PATCH, POST, DELETE, OPTIONS"
                   "Access-Control-Allow-Headers" "Authorization, Content-Type"})
```

<a id="outline-container-the-solution-legacy"></a>

<a id="the-solution-legacy"></a>

## The Solution (Legacy)

<a id="text-the-solution-legacy"></a>

> This section only applies to [Datomic 781-9041](../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and lower.

Add an unauthenticated lambda proxy OPTIONS method to your API gateway. Then add the appropriate CORS headers to the request response from within your application.

<a id="outline-container-adding-the-method"></a>

<a id="adding-the-method"></a>

### Adding The Method

<a id="text-adding-the-method"></a>

- Go to the AWS [API gateway console](https://console.aws.amazon.com/apigateway/home).
- Under the "Actions" dropdown, choose "Create method".
- Select "OPTIONS" from the drop-down
- Click the checkmark next to the dropdown box.
- In "Lambda function", choose the region and lambda function that proxies to your app.
- Click "Save".
- Under the Actions dropdown, select "Deploy API" and use the next window to deploy your API.

<a id="outline-container-legacy-adding-cors-headers-in-your-app"></a>

<a id="legacy-adding-cors-headers-in-your-app"></a>

### Adding CORS Headers in Your App

<a id="text-legacy-adding-cors-headers-in-your-app"></a>

With the above change, requests will now be passed to your application which will be responsible for adding the desired CORS headers. A maximally permissive set of headers is provided here as a reference. You may adjust based on your specific needs:

``` clojure
(def cors-headers {"Access-Control-Allow-Origin" "*"
                   "Access-Control-Allow-Methods" "GET, PUT, PATCH, POST, DELETE, OPTIONS"
                   "Access-Control-Allow-Headers" "Authorization, Content-Type"})
```
