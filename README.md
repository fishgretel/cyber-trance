[![Slack Room][slack-badge]][slack-link]

# Cyber-Trance

A fork of the original [Cyber] Theme:

* Lightweight and simple ➞ **pragmatic**
* Optimized for speed ➞ **no bloat**
* Kinda _semantic coloring_ options (powered by [`cprintf`](https://github.com/Markcial/cprintf)) ➞ **suited for most species**
* Easy to change ➞ **flexible**.

![Cyber-Trance]

## Requirements

The terminal needs to have some capabilities:

* **UTF8** (few characters used)
* **256 colors** or more (all the cool kids have it :children_crossing:)

> Tested on *iTerm2 nightlies*:
>
> `brew cask install iterm2-nightly`

## Integration

While truly optional the following tools are supported:

* [`vcprompt`](https://bitbucket.org/gward/vcprompt) - **git**, **hg**, and **svn** info at low latencies
* [`pyenv`](https://github.com/yyuu/pyenv) - the currently activated **virtualenv** is shown __or__ the version of **Python** currently enabled by *pyenv*
* [`ry`](https://github.com/jneen/ry) - the version of **Ruby** currently enabled by *ry*.

On *OS X* *homebrew* can be used to get these:

```
brew install vcprompt --HEAD
brew install pyenv --HEAD
brew install ry
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

* [Literation Mono](https://github.com/powerline/fonts/tree/master/LiberationMono)

## Got BASH?

If you tend to use `bash` please check out the [`pragmaprompt`](https://github.com/gretel/pragmaprompt) for a similar approach.

[slack-link]: https://fisherman-wharf.herokuapp.com/
[slack-badge]: https://fisherman-wharf.herokuapp.com/badge.svg
[Cyber-Trance]: https://cloud.githubusercontent.com/assets/80815/15529646/1776807a-224f-11e6-8bf0-77c210919af1.png
[Fisherman]: https://github.com/fisherman/fisherman
[Cyber]: https://github.com/fisherman/cyber
[Cyber.terminal]: https://github.com/fishery/cyber/raw/master/Cyber.terminal
[Cyber.itermcolors]: https://github.com/fishery/cyber/raw/master/Cyber.itermcolors
