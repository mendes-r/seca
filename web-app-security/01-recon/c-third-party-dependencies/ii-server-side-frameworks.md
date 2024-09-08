[< back](../../TABLE_OF_CONTENT.md)

# Server-Side Frameworks

## Header Detection

Some insecure configured web server packages expose too much data in the default headers, like:

`X-Powered-By: ASP.NET`

Or even more information:

`Server: Microsoft-IIS/4.5`
`X-AspNet-Version: 4.0.25`

## Default Error Messafes and 404 pages

Some frameworks are open-source, meaning that you have access to their git history. This helps to determine the version used via _fingerprinting_.

Changes in the 404 default pages can help identify the server version being used.

```sh
# Example
git log | grep 404
...
```

## Database Detection

