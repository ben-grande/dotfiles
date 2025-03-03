{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- set qusal_dot = salt["pillar.get"]("qusal:dotfiles:all", default=True) -%}
{%- if salt["pillar.get"]("qusal:dotfiles:gtk", default=qusal_dot) -%}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-gtk-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}/
    - source: salt://{{ slsdotpath }}/files/gtk/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}

"{{ slsdotpath }}-copy-gtk-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/gtk/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: root
    - group: root

{%- else -%}

"{{ sls }}-was-disabled-by-pillar":
  test.nop

{%- endif %}
