#!/bin/sh

exec >> ~/.redshift-hooks.log 2>&1
echo calling $0
echo "$@"
