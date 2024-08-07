{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-dom0-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}
    - source: salt://{{ slsdotpath }}/files/dom0/
    - file_mode: '0644'
    - dir_mode: '0755'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}
    - makedirs: True

"{{ slsdotpath }}-copy-dom0-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/dom0/
    - file_mode: '0644'
    - dir_mode: '0755'
    - user: root
    - group: root
    - makedirs: True
