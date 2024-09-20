{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- if salt['pillar.get']('qusal:dotfiles:all', default=true) == true -%}

include:
  - .copy-dom0
  - .copy-git
  - .copy-gtk
  - .copy-net
  - .copy-pgp
  - .copy-sh
  - .copy-ssh
  - .copy-tmux
  - .copy-vim
  - .copy-x11
  - .copy-xfce

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
