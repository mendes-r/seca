[< back](../../TABLE_OF_CONTENT.md)

# Endpoint Discovery

Is it a RESTful or SOAP API?

Use browser's network tools or Burp to analyze the requests

Look at the _cookie_ getting sent with the request, and look at the _headers_ of each request.

## REST API

### HTTP OPTIONS Verb

Use the method OPTIONS to make requests to the endpoints to give more information about valid HTTP verbs.

```sh
curl -i -X OPTIONS https://api.example.com/user/0001

200 OK
Allow: HEAD, GET, PUT, DELETE, OPTIONS
```

But, generally, OPTIONS will only be available in specially design APIs for public use.

### Brute Forcing

Warning: This can be destructive and is usually logged.

> _Relevant information:_
>
> _Token_ being sent on every request is a sign of a RESTful API design, e.g. stateless
