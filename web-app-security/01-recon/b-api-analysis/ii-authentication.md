[< back](../../TABLE_OF_CONTENT.md)

# Authentication Mechanisms

Analyse the structure of known request sent via browser.

To understand the payload, start with common endpoints like: sign-up, sign-in, password reset...

> The objective is to reverse engineer the type of authentication method and understand how the token is being attached to the request.

| **Authentication scheme**  | **Implementation details**                                    |
|----------------------------|---------------------------------------------------------------|
| HTTP Basic Auth             | Username and password sent on each request, usually in base64 |
| HTTP Digest Authentication | Hashed `username:realm:password` sent on each request         |
| OAuth                      | "Bearer" token-based auth; allows sign-in with other websits  |


Use the browser's _JavaScript_ interpreter to convert a base64 string into plain text:
```js
// Base64 encoding
btoa(str)

// Base64 decoding
atob(base64)
```