{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- if ( (salt['pillar.get']('qusal:dotfiles:all', default=true) == true )
     and (salt['pillar.get']('qusal:dotfiles:sh', default=true) == true )) -%}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-sh-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}/
    - source: salt://{{ slsdotpath }}/files/sh
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}
    - keep_symlinks: True
    - force_symlinks: True

"{{ slsdotpath }}-fix-executables-sh-dir-home":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.local/bin
    - file_mode: '0755'
    - dir_mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-copy-sh-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/sh
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: root
    - group: root
    - keep_symlinks: True
    - force_symlinks: True

"{{ slsdotpath }}-fix-executables-sh-dir-skel":
  file.directory:
    - name: /etc/skel/.local/bin
    - file_mode: '0755'
    - dir_mode: '0755'
    - recurse:
      - mode

{%- else -%}

"{{ sls }}-is-deactivated":
  test.nop

{%- endif %}
