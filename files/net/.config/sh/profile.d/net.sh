#!/bin/sh

## SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
##
## SPDX-License-Identifier: AGPL-3.0-or-later

: "${XDG_CONFIG_HOME:=$HOME/.config}"

CURL_HOME="$XDG_CONFIG_HOME/curl"
WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export CURL_HOME WGETRC
