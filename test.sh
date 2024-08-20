#!/bin/bash -e

if [ ! -f test.mp4 ]
then
    echo "Creating 20MB dummy file..."
    dd if=/dev/zero of=test.mp4 bs=1M count=20
fi


# curl http://localhost:2300/create \
#     -X POST \
#     -H 'Content-Type: video/mp4'

curl http://localhost:2300/create \
    -v \
    -X POST \
    -H 'Content-Type: video/mp4' \
    --data-binary @test.mp4

# curl \
#     'https://staging.ovrcome.io/admin/upload/upload?content_type=image%2Fpng&filename=C%3A%5Cfakepath%5Caws.png&size=31373' \
#     -X POST \
#     -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:129.0) Gecko/20100101 Firefox/129.0' \
#     -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' \
#     -H 'Accept-Encoding: gzip, deflate, br, zstd' \
#     -H 'X-Requested-With: XMLHttpRequest' \
#     -H 'Content-Type: image/png' \
#     -H 'Content-Length: 31373' \
#     -H 'Origin: https://staging.ovrcome.io' \
#     -H 'Connection: keep-alive' \
#     -H 'Referer: https://staging.ovrcome.io/admin/maintenance/audio/new' \
#     -H 'Cookie: session.encrypted=i6vXSekOyOFjqvVLVhmO%0Alw%3D%3D%0AZWtX0UK0zjIP1sOveSb5HWu9n5McYPuEJx1lxyoIxylCMeI92t7T0ib9Exxt%0AIgPNgd7Nha%2BZMGIQkS2flzM%2FVq6NYi34P82wnRf38MG9xyo5S0wmrIHcLkSo%0AFJtHFJOoh%2BiTOZEUdL%2BQcXyDoD1zkQPXVnFjUGHmFYxDtCYxrQq1568vyAAe%0AKTDnW7SCmx6Hd%2B8VLgXwkcMYle8quI79OY7FjihMPBngIEl9U7%2F%2FgD13SCqp%0AJO7yY%2BGPM3BtdCjpVVLJ3npid%2BKnQMIprgoz4F1OEcupme%2F%2FFMnd5Cfb%2BVLl%0A1ZUGyAAJuA7NqtJWdvkW%0A' \
#     -H 'Sec-Fetch-Dest: empty' \
#     -H 'Sec-Fetch-Mode: cors' \
#     -H 'Sec-Fetch-Site: same-origin' \
#     -H 'TE: trailers'
