#!/bin/bash
pandoc "$1" -o "${1%.md}.pdf"
