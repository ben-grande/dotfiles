{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- if (
         salt['pillar.get']('qusal:dotfiles:all', default=true) == true
         or salt['pillar.get']('qusal:dotfiles:x11') == true
       )
-%}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-x11-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}/
    - source: salt://{{ slsdotpath }}/files/x11
    - file_mode: '0755'
    - dir_mode: '0755'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}
    - keep_symlinks: True
    - force_symlinks: True

"{{ slsdotpath }}-copy-x11-skel":
  file.recurse:
    - name: /etc/skel/
    - source: salt://{{ slsdotpath }}/files/x11
    - file_mode: '0755'
    - dir_mode: '0755'
    - user: root
    - group: root
    - keep_symlinks: True
    - force_symlinks: True

{%- else -%}

"{{ sls }}-is-deactivated":
  test.nop

{%- endif %}
