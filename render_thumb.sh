#!/usr/bin/env bash
pdftocairo -png -r 48 -f 1 -l 1 template.pdf
mv template-1.png thumb.png
