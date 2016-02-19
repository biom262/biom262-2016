[![Build Status](https://travis-ci.org/biom262/biom262-2016.svg?branch=master)](https://travis-ci.org/biom262/biom262-2016) [![Join the chat at https://gitter.im/biom262/biom262-2016](https://badges.gitter.im/biom262/biom262-2016.svg)](https://gitter.im/biom262/biom262-2016?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


# Quantitative Methods in Genetics and Genomics 2016



CMM262/BIOM262/BGGN237 Winter 2016

University of California, San Diego (UCSD)

Code and notebooks for BIOM262

[Class website](http://biom262.github.io/biom262-2016)


## Fork and clone the `biom262-2016` Github Repo and start up the week's notebooks

You should have a `code` and `notebooks` directory already. If not, create them. Since the `biom262-2016` is essentially a bunch of code, we'll clone this into the `code` directory. Use your newfound knowledge of `git` and UNIX to go into the `code` directory and clone the class repo:

1. Fork https://github.com/biom262/biom262-2016 to your username
2. Clone your forked repo to your "`~/code`" directory.
3. **Important: Create a branch for this homework** Go into the `biom262-2016` repository and add a branch called the week of homework you're working on, e.g. `week01`. This will allow you to have all your work for this week's homework in one place, and it won't get touched or deleted, even if you update the local code.

When you push code, you'll push to the `week01` branch instead of `master`, e.g.

```
git push origin week01
```

Run this command to add the main `biom262-2016` repository as the "upstream" repository, so you can always pull changes in.
```
git remote add upstream https://github.com/biom262/biom262-2016
```

## What if I already cloned the repo without forking?

No worries - you can still get set up properly. Go to the [biom262-2016](https://github.com/biom262/biom262-2016) repo and click "Fork." Then run these commands:

```
git remote set-url origin https://github.com/yourgithubusername/biom262-2016
git remote add upstream https://github.com/biom262/biom262-2016
```

***Note: you will still need to create  a branch named after the week***
