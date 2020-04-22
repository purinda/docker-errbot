# Errbot on Alpine Linux

This image is influenced from rroemhild/errbot

![Docker Build Status](https://img.shields.io/docker/build/purinda/errbot.svg) ![Docker Stars](https://img.shields.io/docker/stars/purinda/errbot.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/purinda/errbot.svg)

- [Introduction](#introduction)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Image Runtime Config](#image-runtime-config)
    - [Bot Runtime Config](#bot-runtime-config)
- [Persistence](#persistence)
- [Use your own config file](#use-your-own-config-file)
- [Run Err with extra arguments](#run-err-with-extra-arguments)
    - [Alternative config file](#alternative-config-file)
    - [Err Help](#err-help)
    - [Run with text debug backend](#run-with-text-debug-backend)
- [Exposed Ports](#exposed-ports)

# Introduction

Dockerfile to build an [Errbot](http://errbot.io) (the pluggable chatbot) container image.

Version: `latest`
Docker: `purinda/alpine-errbot`

# Quick Start

```
docker run -d \
    --name err \
    -e BACKEND=Slack \
    -e BOT_TOKEN=xoxb-Your-Slack-App-Token \
    -e BOT_ADMINS=@admin-username \
    -e BOT_ALT_PREFIXES=@bot-name-you-setup \
    -e "TZ=Sydney/Australia" \
    purinda/errbot
```

# Configuration

## Image Runtime Config

- **WAIT**: Seconds to sleep before starting the bot. Defaults to `None`

## Bot Runtime Config

Below is the complete list of available options that can be used to customize your Err bot. See [config-template.py](https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py) for complete settings documentation.

- **BACKEND**: Chat server type. (XMPP, Text, HipChat, Slack, IRC). Defaults to `XMPP`.
- **BOT_LOG_LEVEL**: Change log level. Defaults to `INFO`.
- **BOT_USERNAME**: The UID for the bot user.
- **BOT_PASSWORD**: The corresponding password for the user.
- **BOT_TOKEN**: Token for HipChat and Slack backend.
- **BOT_SERVER**: Server address for XMPP and HipChat.
- **BOT_PORT**: Server port.
- **BOT_SSL**: Use SSL for IRC backend. Default to `False`.
- **BOT_ENDPOINT**: HipChat endpoint for hosted HipChat.
- **BOT_NICKNAME**: Nickname for IRC backend.
- **BOT_ADMINS**: Bot admins separated with comma. Defaults to `admin@localhost`.
- **CHATROOM_PRESENCE**: Chatrooms your bot should join on startup.
- **CHATROOM_FN**: The FullName, or nickname, your bot should use. Defaults to `Err`.
- **XMPP_CA_CERT_FILE**: Path to a file containing certificate authorities. Default to `None`.
- **BOT_PREFIX**: Command prefix for the bot. Default to `!`.
- **BOT_PREFIX_OPTIONAL_ON_CHAT**: Optional prefix for normal chat. Default to `False`.
- **BOT_ALT_PREFIXES**: Alternative prefixes.
- **BOT_ALT_PREFIX_SEPARATORS**: Alternative prefixes separators.
- **BOT_ALT_PREFIX_CASEINSENSITIVE**:  Require correct capitalization. Defaults to `False`.
- **HIDE_RESTRICTED_COMMANDS**: Hide the restricted commands from the help output. Defaults to `False`.
- **HIDE_RESTRICTED_ACCESS**: Do not reply error message. Defaults to `False`.
- **DIVERT_TO_PRIVATE**: Private commands.
- **MESSAGE_SIZE_LIMIT**: Maximum length a single message may be. Defaults to `10000`.
- **BOT_EXTRA_PLUGIN_DIR**: Directory to load extra plugins from. Defaults to `/srv/plugins`.
- **CORE_PLUGINS**: comma-separated subset of the core plugins to load. Defaults to all plugins which are bundled with Errbot.

# Persistence

For storage of the application data, you should mount a volume at

* `/srv`

Create the directories for the volume

```bash
mkdir /tmp/errbot /tmp/errbot/ssl /tmp/errbot/data /tmp/errbot/plugins
chmod -R 777 /tmp/errbot
```

# Use your own config file

```bash
curl -sL https://raw.githubusercontent.com/gbin/err/master/errbot/config-template.py -o /tmp/errbot/config.py
```

# Run Err with extra arguments

If you pass arguments to Errbot you have to set the `-c /srv/config.py` argument by your self to run with the default config.

## Alternative config file

```bash
docker run -it -v /tmp/errbot:/srv purinda/errbot -c /srv/production.py
```

## Err Help

```bash
$ docker run purinda/errbot -h
```

## Run with text debug backend

```bash
docker run -it -v /tmp/errbot:/srv purinda/errbot -c /srv/config.py -T
```

# Exposed Ports

* 3142 (Webserver if configured)
