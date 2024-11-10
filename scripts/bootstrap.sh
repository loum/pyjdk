#!/bin/sh

if [ -n "$PYSPARK_VERSION" ]
then
    python3 -m pip install --user --no-cache-dir pyspark=="$PYSPARK_VERSION"
    .local/bin/pyspark "$@"
else
    "$@"
fi
