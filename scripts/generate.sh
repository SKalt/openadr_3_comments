#!/bin/sh
set -eu
_lang=${1:-${OUTPUT_LANG:-go}}

rm -rf "out/spec/$_lang"
rm -rf "out/ri/$_lang"
echo '*' > "out/.gitignore"

echo "spec::openapi-codegen ###################################"
echo
docker run --rm \
    -v "$PWD:/local" \
    docker.io/openapitools/openapi-generator-cli generate \
    -i /local/1_oadr3.0.1.yaml \
    -g "$_lang" \
    -o "/local/out/spec/$_lang/openapi-codegen"

echo
echo "spec::swagger-codegen ###################################"
echo
docker run --rm \
  -v "$PWD:/local" \
  docker.io/swaggerapi/swagger-codegen-cli-v3 generate \
  -i /local/1_oadr3.0.1.yaml \
  -l "$_lang" \
  -o "/local/out/spec/$_lang/swagger-codegen"

echo
echo "ri::openapi-codegen ###################################"
echo
docker run --rm \
  -v "$PWD:/local" \
  docker.io/openapitools/openapi-generator-cli generate \
  -i /local/ri.yaml \
  -g "$_lang" \
  -o "/local/out/ri/$_lang/openapi-codegen"

echo
echo "ri::swagger-codegen ###################################"
echo
docker run --rm \
  -v "$PWD:/local" \
  docker.io/swaggerapi/swagger-codegen-cli-v3 generate \
  -i /local/ri.yaml \
  -l "$_lang" \
  -o "/local/out/ri/$_lang/swagger-codegen"
