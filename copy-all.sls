{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- if  salt["pillar.get"]("qusal:dotfiles:all", default=True) or
        salt["pillar.get"]("qusal:dotfiles:dom0") or
        salt["pillar.get"]("qusal:dotfiles:git") or
        salt["pillar.get"]("qusal:dotfiles:gtk") or
        salt["pillar.get"]("qusal:dotfiles:mutt") or
        salt["pillar.get"]("qusal:dotfiles:net") or
        salt["pillar.get"]("qusal:dotfiles:pgp") or
        salt["pillar.get"]("qusal:dotfiles:sh") or
        salt["pillar.get"]("qusal:dotfiles:ssh") or
        salt["pillar.get"]("qusal:dotfiles:tmux") or
        salt["pillar.get"]("qusal:dotfiles:vim") or
        salt["pillar.get"]("qusal:dotfiles:x11")
-%}

include:
  - {{ slsdotpath }}.copy-dom0
  - {{ slsdotpath }}.copy-git
  - {{ slsdotpath }}.copy-gtk
  - {{ slsdotpath }}.copy-mutt
  - {{ slsdotpath }}.copy-net
  - {{ slsdotpath }}.copy-pgp
  - {{ slsdotpath }}.copy-sh
  - {{ slsdotpath }}.copy-ssh
  - {{ slsdotpath }}.copy-tmux
  - {{ slsdotpath }}.copy-vim
  - {{ slsdotpath }}.copy-x11

{%- else -%}

"{{ sls }}-was-disabled-by-pillar":
  test.nop

{%- endif -%}

{#
Unfortunately salt.states.file does not keep permissions when using salt-ssh.
Best option is 'file.managed mode: keep' or 'file.recurse file_mode: keep'.
https://docs.saltproject.io/en/latest/ref/states/all/salt.states.file.html
#}
{#

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-absent-dotfiles-client":
  file.absent:
    - name: /tmp/dotfiles

"{{ slsdotpath }}-copy-dotfiles-client":
  file.recurse:
    - source: salt://{{ slsdotpath }}/files
    - name: /tmp/dotfiles
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}

"{{ slsdotpath }}-apply-dotfiles-client":
  cmd.run:
    - name: sh /tmp/dotfiles/setup.sh
    - runas: {{ gui_user.gui_user }}

"{{ slsdotpath }}-fix-executables-permission":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.local/bin
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-absent-end-dotfiles-client":
  file.absent:
    - name: /tmp/dotfiles
#}
