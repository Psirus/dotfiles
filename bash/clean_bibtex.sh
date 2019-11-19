#!/bin/bash
sed -i '/Crossref/d' "$1"
sed -i '/cpohl/d' "$1"
sed -i '/timestamp/d' "$1"
