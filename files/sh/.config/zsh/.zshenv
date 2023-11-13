#!/usr/bin/env zsh

## SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
##
## SPDX-License-Identifier: AGPL-3.0-or-later

if test -z "$ENV" && test -n "$PATH"; then
  case $- in
    *l*) ;;
      *) . "$HOME/.zprofile" >/dev/null ;;
  esac
fi
