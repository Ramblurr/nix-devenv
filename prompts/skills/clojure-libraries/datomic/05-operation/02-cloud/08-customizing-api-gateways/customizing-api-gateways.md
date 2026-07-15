<a id="content"></a>

<a id="customizing-api-gateways"></a>

# Customizing API Gateways

By default, every Datomic [compute group](../01-cloud-architecture/cloud-architecture.md#compute-groups) manages two API Gateways: one for client access, and another for [ion applications](../../../07-datomic-cloud-ions/01-ions-overview/ions-overview.md). This page covers circumstances where you may want to go beyond Datomic's built-in API Gateway support:

- [Creating a custom domain for Datomic's API Gateways](#custom-domain)
- [Creating your own API Gateways](#creating-your-apigateway)

<a id="outline-container-custom-domain"></a>

<a id="custom-domain"></a>

## Creating a Custom Domain

<a id="text-custom-domain"></a>

The API Gateways managed by Datomic have generated endpoint names of the form <https://%7Bapi-id%7D.execute-api.%7Bregion%7D.amazonaws.com/>. If you want friendly custom domains in addition to these generated names, you can configure them either through [Route53](#route-53) or [your own DNS servers/registrar](#users-dns).

Both methods described use [AWS Certificate Manager](https://console.aws.amazon.com/acm/home).

<a id="outline-container-route-53"></a>

<a id="route-53"></a>

### Route53

<a id="text-route-53"></a>

> These instructions assume that you're using a subdomain.

The AWS Certificate Manager instructions may differ based on your needs. These instructions provide a basic overview of how to set up a custom domain name.

<a id="outline-container-route-53-aws-certificate-manager"></a>

<a id="route-53-aws-certificate-manager"></a>

#### AWS Certificate Manager

<a id="text-route-53-aws-certificate-manager"></a>

- Go to [AWS Certificate Manager](https://console.aws.amazon.com/acm/home)
- Possibly click Provision Certificates
- Request a certificate
- Select Request a public certificate
- Click "Request a certificate"
- Enter the domain name that you wish to use
- Click "Next"
- Select the DNS validation method that you wish to use
- Click "Next"
- Add any tags that you would like for easier identification of this Certificate later
- Click "Review"
- Review your selections
- Click "Confirm and request"
- If you used DNS Validation:
  - Click the down arrow next to the domain name in the "Domain" box
  - Click "Create a record in Route 53"
  - Review the information on the next screen.
  - Click "Create"
- Once the Certificate's status in ACM is completed, proceed to the next step

<a id="outline-container-route-53-api-gateway"></a>

<a id="route-53-api-gateway"></a>

#### API Gateway

<a id="text-route-53-api-gateway"></a>

- Go to [API Gateway](https://console.aws.amazon.com/apigateway/main/apis)
- Select the API that you want to connect a custom domain name to
- Click "Custom domain names"
- Click "Create"
- Enter the desired domain name
- Leave the defaults
  - TLS 1.2
  - Mutual authentication off
  - Endpoint type: regional
- Select the ACM Certificate that you created earlier or the appropriate existing ACM Certificate
- Add any tags that you would like for easier identification of this custom domain later
- Click "Create Domain Name"
- On the following page for the newly created domain name, click the "API mappings" tab
  - Click "Configure API mappings"
  - Click "Add new mapping"
  - Select the API that you want to connect a custom domain name to
  - Select the appropriate stage, likely `$default`
  - Click "Save"
- Under "Configurations" copy and save the API Gateway domain name for the next step

<a id="outline-container-route53"></a>

<a id="route53"></a>

#### Route53

<a id="text-route53"></a>

- Go to [Route53](https://console.aws.amazon.com/route53/v2/home)
- Click "Hosted Zones"
- Click the domain name that you are using
- Create record
- Record type "A" or "AAA"
- Record name is the subdomain used previously
- Route traffic to "Alias to API Gateway API"
- Choose the appropriate region
- Choose the endpoint matching the name that you saved earlier
- Click "Create Records"

After the DNS propagates, you will be able to visit a domain connected to a Client API Gateway and get a response similar to:

``` clojure
{:s3-auth-path "<stack-name>-storagef7f305e7-z5ezcdtid-s3datomic-2n2m24rzlu6al"}
```

<a id="outline-container-users-dns"></a>

<a id="users-dns"></a>

### Your DNS Servers

<a id="text-users-dns"></a>

> These instructions assume that you're using a subdomain.

The AWS Certificate Manager instructions may differ based on your needs. These instructions provide a basic overview of how to set up a custom domain name.

<a id="outline-container-users-dns-aws-certificate-manager"></a>

<a id="users-dns-aws-certificate-manager"></a>

#### AWS Certificate Manager

<a id="text-users-dns-aws-certificate-manager"></a>

- Go to [AWS Certificate Manager](https://console.aws.amazon.com/acm/home)
- Possibly click "Provision certificates"
- Request a certificate
- Select Request a public certificate
- Click "Request a certificate"
- Enter the domain name that you wish to use
- Click "Next"
- Select the DNS validation method that you wish to use
- Click "Next"
- Add any tags that you would like for easier identification of this certificate later
- Click "Review"
- Review your selections
- Click "Confirm and request"

<a id="outline-container-users-dns-api-gateway"></a>

<a id="users-dns-api-gateway"></a>

#### API Gateway

<a id="text-users-dns-api-gateway"></a>

- Go to [API Gateway](https://console.aws.amazon.com/apigateway/main/apis)
- Select the API that you want to connect a custom domain name to
- Click "Custom domain names"
- Click "Create"
- Enter the desired domain name
- Leave the defaults
  - TLS 1.2
  - Mutual authentication off
  - Endpoint type: regional
- Select the ACM Certificate that you created earlier or the appropriate existing ACM Certificate
- Add any tags that you would like for easier identification of this custom domain later
- Click "Create domain name"
- On the following page for the newly created domain name, click the "API mappings" tab
  - Click "Configure API mappings"
  - Click "Add new mapping"
  - Select the API that you want to connect a custom domain name to
  - Select the appropriate stage, likely ~\$default~\>
  - Click "Save"

<a id="outline-container-dns"></a>

<a id="dns"></a>

#### DNS

<a id="text-dns"></a>

- Go to where you manage your DNS
- Subdomain - if you used a subdomain:
  - Create a new CNAME record
  - Host is the API gateway domain name listed under your custom domain names endpoint configuration
  - Value is the API gateway endpoint URL

After the DNS propagates, you will be able to visit a domain connected to a client API gateway and get a response similar to:

``` clojure
{:s3-auth-path "<stack-name>-storagef7f305e7-z5ezcdtid-s3datomic-2n2m24rzlu6al"}
```

Ion API gateway domains will need to be verified using your HTTP direct invoke method.

<a id="outline-container-creating-your-apigateway"></a>

<a id="creating-your-apigateway"></a>

## Creating Your Own API Gateway

<a id="text-creating-your-apigateway"></a>

Datomic's built-in API Gateways will cover the majority of use cases, but it is possible to create your own API Gateways in addition to, or instead of, the API Gateways managed by Datomic. The instructions below cover creating and using your own API Gateways, both for Datomic clients and for ion applications.

<a id="outline-container-find-load-balancer"></a>

<a id="find-load-balancer"></a>

### Find Load Balancer Name

<a id="text-find-load-balancer"></a>

- Go to [Cloudformation](https://console.aws.amazon.com/cloudformation/)
- Select your master stack, primary compute group, or query group that you want to add an endpoint to
- Click the "Outputs" tab
- Search for "LoadbalancerName" and take note of the associated value

<a id="outline-container-create-api-gateway"></a>

<a id="create-api-gateway"></a>

### Create API Gateway

<a id="text-create-api-gateway"></a>

- Go to the [API Gateway](https://console.aws.amazon.com/apigateway/main/apis)
- Click "Create API"
- Click "Build" under "HTTP API"
- API name - "datomic-\<system-name\>-Client" or "datomic-\<system-name\>-HTTP-Direct" is suggested, depending on the gateway type
- Click "Next" on the configure routes page
- Use the default Stage name value of `$default`. Click "Next"
- Do not try to edit integrations at this time
- Click "Create"

<a id="outline-container-create-a-route"></a>

<a id="create-a-route"></a>

### Create a Route

<a id="text-create-a-route"></a>

- On the page for your newly created API, click "Routes"
- Path - `$default`
  - A Client Access gateway must use a `$default` path. HTTP Direct access can be set up according to your needs

<a id="outline-container-create-an-integration"></a>

<a id="create-an-integration"></a>

### Create an Integration

<a id="text-create-an-integration"></a>

- Click "Integrations"
- Select your `default` path
- Click "Create and attach an integration"
- Integration type: private resource
- Selection method: select manually
- Target service: ALB/NLB
- Load balancer: use the value previously located in CloudFormation
- Listener
  - TCP ****8182**** for client access
  - TCP ****8184**** for HTTP direct access
- VPC link: select the name of your system
- Click "Create"

<a id="outline-container-your-client-apigateway"></a>

<a id="your-client-apigateway"></a>

### Using Your Client Access API Gateway

<a id="text-your-client-apigateway"></a>

- Go to [API gateway](https://console.aws.amazon.com/apigateway/main/apis)
- Select the API that you created for client

Your endpoint is now displayed in the "Stages" section of your API's page in [API Gateway](https://console.aws.amazon.com/apigateway/main/apis). Curl or view the link in your web browser. You should see text that looks like `{:s3-auth-path "my-datomic-systems3datomic-m62qe9be3uwp"}`. The exact value will differ for you.

<a id="outline-container-your-HTTP-apigateway"></a>

<a id="your-HTTP-apigateway"></a>

### Using Your HTTP Direct Access API Gateway

<a id="text-your-HTTP-apigateway"></a>

The HTTP Direct endpoint [is used to access your ions over the internet](../../../07-datomic-cloud-ions/07-entry-points/entry-points.md#http-direct).
