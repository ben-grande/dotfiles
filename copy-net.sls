{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- set qusal_dot = salt["pillar.get"]("qusal:dotfiles:all", default=True) -%}
{%- if salt["pillar.get"]("qusal:dotfiles:net", default=qusal_dot) -%}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-net-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}/
    - source: salt://{{ slsdotpath }}/files/net/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}
    - keep_symlinks: True
    - force_symlinks: True

"{{ slsdotpath }}-copy-net-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/net/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: root
    - group: root
    - keep_symlinks: True
    - force_symlinks: True

"{{ slsdotpath }}-fix-executables-net-bin-dir-home":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.local/bin
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-fix-executables-net-bin-dir-skel":
  file.directory:
    - name: /etc/skel/.local/bin
    - mode: '0755'
    - recurse:
      - mode

{%- else -%}

"{{ sls }}-was-disabled-by-pillar":
  test.nop

{%- endif %}
