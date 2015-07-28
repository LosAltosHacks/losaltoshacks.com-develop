## libx

```
lib/
```
any common code for client/server.


```
lib/environment.js
```
general configuration


```
lib/external
```
common code from someone else


###### Note that js files in lib folders are loaded before other js files.

## models

```
models/
```
definitions of collections and methods on them (could be models/)


## client

```
client/lib
```
client specific libraries (also loaded first)


```
client/lib/environment.js
```
configuration of any client side packages


```
client/lib/helpers
```
any helpers (handlebars or otherwise) that are used often in view files


```
client/application.js
```
subscriptions, basic Meteor.startup code.


```
client/index.html
```
toplevel html


```
client/index.js
```
and its JS


```
client/views/<page>.html
```
the templates specific to a single page


```
client/views/<page>.js
```
and the JS to hook it up


```
client/views/<type>/
```
if you find you have a lot of views of the same object type


```
client/stylesheets/
```
css / styl / less files


## server

```
server/publications.js
```
Meteor.publish definitions

```
server/methods.js
```
Meteor.method definitions

```
server/lib/environment.js
```
configuration of server side packages


## public

```
public/
```
static files, such as images, that are served directly.
