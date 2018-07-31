#/bin/bash
set -eu

cd $(dirname "$0")

./setup.sh

docker build -t tizen/stub:latest -f tizen-stub.Dockerfile .

echo "Done!"
