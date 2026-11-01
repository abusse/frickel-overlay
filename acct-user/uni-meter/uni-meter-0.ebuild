# Copyright 2026
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for uni-meter service"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( uni-meter )
ACCT_USER_HOME="/var/lib/uni-meter"
ACCT_USER_SHELL="/sbin/nologin"

acct-user_add_deps
