{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

"{{ slsdotpath }}-copy-ssh-home":
  file.recurse:
    - name: /home/user/
    - source: salt://{{ slsdotpath }}/files/ssh/
    - file_mode: '0600'
    - dir_mode: '0700'
    - user: user
    - group: user
    - backup: minion

"{{ slsdotpath }}-copy-ssh-skel":
  file.recurse:
    - name: /etc/skel/
    - source: salt://{{ slsdotpath }}/files/ssh/
    - file_mode: '0600'
    - dir_mode: '0700'
    - user: root
    - group: root
