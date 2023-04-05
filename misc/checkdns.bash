#!/bin/bash

DOMAIN_NAME="katogana.de"

for f in Tokyo8-{1,2,3,4} Toronto8-{1,2,3} {NewYork,London}9-{1,2} OL{8,9}GoldenInstance{1,2}; do
  dig ${f}.${DOMAIN_NAME} | egrep "^${f}"
done

