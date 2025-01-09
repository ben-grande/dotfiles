{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- import "dom0/gui-user.jinja" as gui_user -%}

"{{ slsdotpath }}-copy-git-home":
  file.recurse:
    - name: {{ gui_user.gui_user_home }}
    - source: salt://{{ slsdotpath }}/files/git
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: {{ gui_user.gui_user }}
    - group: {{ gui_user.gui_user }}

"{{ slsdotpath }}-fix-executables-git-template-dir-home":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.config/git/template/hooks
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-fix-executables-git-shell-dir-home":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.config/git/shell
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-fix-executables-git-bin-dir-home":
  file.directory:
    - name: {{ gui_user.gui_user_home }}/.local/bin
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-copy-git-skel":
  file.recurse:
    - name: /etc/skel
    - source: salt://{{ slsdotpath }}/files/git
    - file_mode: '0644'
    - dir_mode: '0700'
    - user: root
    - group: root

"{{ slsdotpath }}-fix-executables-git-template-dir-skel":
  file.directory:
    - name: /etc/skel/.config/git/template/hooks
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-fix-executables-git-shell-dir-skel":
  file.directory:
    - name: /etc/skel/.config/git/shell
    - mode: '0755'
    - recurse:
      - mode

"{{ slsdotpath }}-fix-executables-git-bin-dir-skel":
  file.directory:
    - name: /etc/skel/.local/bin
    - mode: '0755'
    - recurse:
      - mode
