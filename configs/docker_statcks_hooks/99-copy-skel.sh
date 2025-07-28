#!/bin/bash
# This script runs in the new users home directory.
set -x
cp -r --update=none /etc/skel/.??* /etc/skel/* "$PWD"