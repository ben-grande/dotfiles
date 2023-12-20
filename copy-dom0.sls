{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

"{{ slsdotpath }}-copy-dom0-home":
  file.recurse:
    - name: /home/user/
    - source: salt://{{ slsdotpath }}/files/dom0/
    - file_mode: '0644'
    - dir_mode: '0755'
    - user: user
    - group: user
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
