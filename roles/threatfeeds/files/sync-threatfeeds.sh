#!/bin/bash

mkdir -p /var/log/threatfeeds
FEED_DIR="/etc/unbound/threatfeeds"

mkdir -p "$FEED_DIR"

wget -q -O "$FEED_DIR/malicious.txt" https://some-threat-feed.example.com/list.txt

# Optional post-processing (deduplication, formatting)
sort -u "$FEED_DIR/malicious.txt" -o "$FEED_DIR/malicious.txt"
