
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

To view it at [http://localhost:8080](http://localhost:8080), do:

```
wintersmith preview
```


## Editing the website

The main file is `templates/index.jade`, which is written in the [jade](http://jade-lang.com/) template engine. The layout/base for the page is specified in `templates/layout.jade`.

### Note about CSS

Due to restrictions in the way that Github Pages are built, the website will always reference CSS from `http://biom262.github.io/biom262-2016/css`, not from your local machine. If you're running into CSS issues, it's probably because it's fetching the remote css. To fix this, when you do "Inspect Element" edit the CSS stylesheet calls from:

```
<link rel="stylesheet" href="http://biom262.github.io/biom262-2016/css/normalize.css">
```

to:

```
<link rel="stylesheet" href="/css/normalize.css">
```

You'll need to do this for all three (`normalize.css`, `main.css`, `skeleton.css`)
