[< back](../TABLE_OF_CONTENT.md)

# Organization

- keep notes during recon.
- use a parsable format, like JSON, to organize found subdomains and endpoints.

## Template

### Main set of notes

- Technology used in the web application;
- List of API endpoints by HTTP verb;
- List of API endpoints shapes  (where available), i.e headers, payloads;
- Functionality included in the web application, e.g. comments, auth, notifications, etc;
- Domains used by the web application;
- Configurations found, e.g. Content Security Policy (CSP);
- Authentication/session management system.

### Format

```js
{
    api_endpoints: {
        sign_up: {
            url: 'example.com/auth/sign_up',
            method: 'POST',
            shape: {
                username: { type: String, required: true, min: 6, max: 18 },
                password: { type: String, required: true, min: 6, max: 32 },
                referralCode: { type: String, required: false, min: 64, max: 64 },
            }
        },
        reset_password: {
            url: 'example.com/auth/reset',
            method: 'POST',
            shape: {
                username: { type: String, required: true, min: 6, max: 18 },
                password: { type: String, required: true, min: 6, max: 32 },
                newPassword: { type: String, required: true, min: 6, max: 32 },
            }
        },
    },
    features: {
        comments: {},
        uploads: {
            file_sharing: {}
        },
    },
    integrations: {
        oath: {
            twitter: {},
            facebook: {},
            youtube: {}
        }
    }
}
```