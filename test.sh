#!/bin/bash -e

echo "Testing with 1 byte file..."
if [ ! -f test.1b.txt ]; then
    dd if=/dev/zero of=test.1b.txt bs=1 count=1 > /dev/null
fi

curl http://localhost:2300/create \
    -v \
    -H 'Content-Type: video/mp4' \
    --data-binary @test.1b.txt

echo "Testing with 20MB dummy file..."
if [ ! -f test.20MB.mp4 ]; then
    dd if=/dev/zero of=test.20MB.mp4 bs=1M count=20 > /dev/null
fi

curl http://localhost:2300/create \
    -v \
    -H 'Content-Type: video/mp4' \
    --data-binary @test.20MB.mp4
