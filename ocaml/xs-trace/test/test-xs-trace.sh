#!/bin/bash
set -eux

export PATH_TO_FILE=$(pwd)

./test_xs_trace.exe &

PID=$!

touch "test-file"

echo "Testing 1"

ls $PATH_TO_FILE/test-socket

echo "Testing"

../xs_trace.exe cp test-source.json file://$PATH_TO_FILE/test-socket

diff test-source.json test-http-server.out || exit 1

rm test-http-server.out

../xs_trace.exe cp test-source.ndjson file://$PATH_TO_FILE/test-socket

diff test-source.ndjson test-http-server.out || exit 1

kill $PID
