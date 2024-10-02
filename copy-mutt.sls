{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>
SPDX-FileCopyrightText: 2024 seven-beep <ebn@entreparentheses.xyz>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- if ( (salt['pillar.get']('qusal:dotfiles:all', default=true) == true )
     and (salt['pillar.get']('qusal:dotfiles:mutt', default=true) == true )) -%}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-mutt-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}/
    - source: salt://{{ slsdotpath }}/files/mutt/
    - file_mode: '0644'
    - dir_mode: '0755'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}
    - makedirs: True

"{{ slsdotpath }}-copy-mutt-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/mutt/
    - file_mode: '0644'
    - dir_mode: '0755'
    - user: root
    - group: root
    - makedirs: True

{%- else -%}

"{{ sls }}-is-deactivated":
  test.nop

{%- endif %}
