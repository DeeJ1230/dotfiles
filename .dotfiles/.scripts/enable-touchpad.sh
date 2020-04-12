#!/usr/bin/env bash

xinput list | grep -i touchpad | \
  awk '{print $6}' | awk -F '=' '{print $2}' | \
  xargs -rn 1 -I {} xinput --enable {}
