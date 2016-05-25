[![Slack Room][slack-badge]][slack-link]

# Cyber-Trance

**Work in progress!**
___

A fork of the original [Cyber] Theme:

* Lightweight and simple, _pragmatic_!
* Optimized for speed, _no bloat_!
* Kinda _semantic coloring_ options (powered by [`cprintf`](https://github.com/Markcial/cprintf))
* Easy to change, _flexible_!

![Cyber-Trance]

## Requirements

The terminal needs to have some capabilities:

* *UTF8* (few chars used)
* *256 colors* or more (all the cool kids have it)

> Tested on *iTerm3 nightlies*.

## Integration

While truly optional the following tools are supported:

* [`vcprompt`](https://bitbucket.org/gward/vcprompt) - *git*, *hg*, and *svn* info at low latencies
* [`pyenv`](https://github.com/yyuu/pyenv) - the currently activated *virtualenv* is shown - nice for *Python* hack*etc - otherwise maybe not.

On *OS X* *homebrew* can be used to get these:

```
brew install pyenv
brew install vcprompt --HEAD
```

> Note: The *bitbucket* repo of `vcprompt` *homebrew* uses is one of the few actually being maintained.

## Install

With [fisherman]

```fish
fisher fishgretel/cyber-trance
```

## Terminal Settings

Works well with the original color sets

* [Cyber.terminal]
* [Cyber.itermcolors]

A recommandable and well-matching font:

* Font: 12pt Literation Mono

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[Cyber-Trance]: https://cloud.githubusercontent.com/assets/80815/15529646/1776807a-224f-11e6-8bf0-77c210919af1.png
[Fisherman]: https://github.com/fisherman/fisherman
[Cyber]: https://github.com/fisherman/cyber
[Cyber.terminal]: https://github.com/fishery/cyber/raw/master/Cyber.terminal
[Cyber.itermcolors]: https://github.com/fishery/cyber/raw/master/Cyber.itermcolors
