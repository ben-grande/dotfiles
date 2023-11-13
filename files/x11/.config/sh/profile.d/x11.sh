#!/bin/sh

## SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
##
## SPDX-License-Identifier: AGPL-3.0-or-later

: "${XDG_CONFIG_HOME:=$HOME/.config}"

XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export XINITRC
