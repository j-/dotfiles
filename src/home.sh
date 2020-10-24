#!/bin/sh

find ./home \
  -mindepth 1 \
  -maxdepth 1 \
  -type f \
  -exec cp -i {} ~ \;
