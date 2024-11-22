#!/bin/sh
_lang=${1:-${OUTPUT_LANG:-go}}
rm -rf "out/$_lang"

docker run --rm \
    -v "$PWD:/local" \
    docker.io/openapitools/openapi-generator-cli generate \
    -i /local/1_oadr3.0.1.yaml \
    -g "$_lang" \
    -o "/local/out/$_lang"

# swagger-codegen seems to think this is a JSON file.
# docker run --rm \
#     -v "$PWD:/local" \
#     docker.io/swaggerapi/swagger-codegen-cli generate \
#     -i /local/1_oadr3.0.1.yaml \
#     -l "$_lang" \
#     -o "/local/out/$_lang"

echo '*' > "out/$_lang/.gitignore"
