{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

"{{ slsdotpath }}-copy-gtk-home":
  file.recurse:
    - name: /home/user/
    - source: salt://{{ slsdotpath }}/files/gtk/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: user
    - group: user

"{{ slsdotpath }}-copy-gtk-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/gtk/
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: root
    - group: root
