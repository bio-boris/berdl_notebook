#!/bin/bash
echo "Copying skeleton files to $PWD ..."
cp -r --update=none /configs/skel/* "$PWD"