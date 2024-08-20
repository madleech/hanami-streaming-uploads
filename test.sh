#!/bin/bash -e

if [ ! -f test.mp4 ]
then
    echo "Creating 20MB dummy file..."
    dd if=/dev/zero of=test.mp4 bs=1M count=20
fi

curl http://localhost:2300/create \
    -v \
    -H 'Content-Type: video/mp4' \
    --data-binary @test.mp4
