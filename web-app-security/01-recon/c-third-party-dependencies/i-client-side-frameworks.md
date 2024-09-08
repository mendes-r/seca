[< back](../../TABLE_OF_CONTENT.md)

# Client-Side Frameworks

Pin down the used framework and version number, can open the possibility of finding applicable ReDos, prototype pollution and XSS vulnerabilities on the web.

## SPA Frameworks

### EmberJS (LinkedIn, Netflix)

- Tag `ember-id` in DOM elements, e.g. `id=ember1`.
- Global variable `Ember`

```js
// 3.1.0
console.log(Ember.VERSION);
```

### Angular (Google)

- Older versions < Angular 4.0

```js
console.log(angular.version);
````

- Newer versions Angular 4.0+

```js
// returns array of root elements
const elements = getAllAngularRootElements();
const version = elements[0].attributes['ng-version'];

// ng-version="6.1.2"
console.log(version);
```

### React (Facebook)

```js
const version = React.version;

// 0.13.3
console.log(version);
```

- Another options is to find script tags with type `text/jsx` refering React's special file format. This file contains JS, CSS and HTML for a individual component.

### VueJS (Adobe, Gitlab)

```js
const version = Vue.version;

// 2.6.10
console.log(version);
```

If inspecting elements on a VueJS app is not possible is probably because the developer tools were disabled.

To enable them again run the following code:

```js
// Vue components can now be inspected
Vue.config.devtools = true;
```

## JavaScript Libraries

Some libraries expose global variables using specific symbols, e.g. underscore `(_)` for _Underscore_ and _Lodash_, and dollar sign `($)` for JQuery.

Traverse DOM to generate a list of each `<script>` tag imported:

```js
const getScripts = function() {

    /*
    * Query selector "." refers to CSS classes
    * Query selector "#" refers to 'id' attributes
    * No prefix refers to HTML elements
    */
    const scripts = document.querySelectorAll('script');

    scripts.forEach((script) => {
        if (script.src) {
            console.log(`i: ${script.src}`);
        }
    });
};
```


## CSS Libraries

```js
const getStyles = function() {

    const scripts = document.querySelectorAll('link');

    /*
    * Iterate through each script, and confirm that the 'link' element contains a 'rel' attribute with the value of 'stylesheet'.
    *
    * Link us a multipurpose element most commonly used for loading CSS stylesheets, but also used for preloading, icons, or search
    */
    scripts.forEach((link) => {
        if (link.rel === 'stylesheet') {
            console.log(`i: ${link.getAttribute('href')}`);
        }
    });
};
```


