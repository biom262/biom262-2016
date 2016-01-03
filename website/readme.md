
# Blog

The default [wintersmith](https://github.com/jnordberg/wintersmith) template

## To build this website

You will need the node.js package `wintersmith` (linked above)

```
npm install wintersmith -g
```

And to build it, do

```
wintersmith build
```

To view it at http://localhost:8080, do:

```
wintersmith preview
```


## Editing the website

The main file is `templates/index.jade`, which is written in the [jade](http://jade-lang.com/) template engine. The layout/base for the page is specified in `templates/layout.jade`.
