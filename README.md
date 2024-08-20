# Upload

Quick example of trying to stream data from Hanami to S3.

Files of note:
* `app/actions/create.rb` -- logic that handles streaming request body to S3.

## Expectations

When posting binary content to the upload script, it should pass the request body directly to the S3 `#put` method, which accepts `String`, `StringIO`, or `File` data. The data should be streamed by the `#put` method directly to S3 without buffering the data.

## Actual Result

Client:
```
$ ./test.sh
*   Trying 127.0.0.1:2300...
* Connected to localhost (127.0.0.1) port 2300 (#0)
> POST /create HTTP/1.1
> Host: localhost:2300
> User-Agent: curl/7.81.0
> Accept: */*
> Content-Type: video/mp4
> Content-Length: 20971520
> Expect: 100-continue
> 
* Done waiting for 100-continue
* We are completely uploaded and fine
* Mark bundle as not supporting multiuse
< HTTP/1.1 500 Internal Server Error
< content-type: text/plain
< vary: accept-encoding
< content-length: 62
< 
* Connection #0 to host localhost left intact
ArgumentError: wrong number of arguments (given 2, expected 1)
```

Server:
```
 3.86s    error: Protocol::Rack::Adapter::Rack2: Reading HTTP/1.1 requests for Async::HTTP::Protocol::HTTP1::Server. [oid=0x2648] [ec=0x265c] [pid=1611996] [2024-08-21 11:22:02 +1200]
               |   ArgumentError: wrong number of arguments
               |   → .../gems/protocol-http-0.28.1/lib/protocol/http/body/stream.rb:114 in `readpartial'
               |     .../ruby/3.3.0/net/http/generic_request.rb:282 in `copy_stream'
               |     .../ruby/3.3.0/net/http/generic_request.rb:282 in `send_request_with_body_stream'
               |     .../ruby/3.3.0/net/http/generic_request.rb:202 in `exec'
               |     .../ruby/3.3.0/net/http.rb:2335 in `block in transport_request'
               |     .../ruby/3.3.0/net/http.rb:2333 in `catch'
               |     .../ruby/3.3.0/net/http.rb:2333 in `transport_request'
               |     .../ruby/3.3.0/net/http.rb:2306 in `request'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/connection_pool.rb:342 in `request'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/handler.rb:74 in `block in transmit'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/handler.rb:128 in `block in session'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/connection_pool.rb:104 in `session_for'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/handler.rb:123 in `session'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/handler.rb:71 in `transmit'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/net_http/handler.rb:45 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/content_length.rb:24 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/request_callback.rb:118 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/s3_signer.rb:78 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/s3_host_id.rb:17 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/http_200_errors.rb:17 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/xml/error_handler.rb:10 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/sign.rb:53 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/transfer_encoding.rb:27 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/helpful_socket_errors.rb:12 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/s3_signer.rb:53 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/redirects.rb:20 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/user_agent.rb:63 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/retry_errors.rb:365 in `block in call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/user_agent.rb:51 in `metric'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/retry_errors.rb:385 in `with_metric'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/retry_errors.rb:365 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/md5s.rb:32 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/http_checksum.rb:20 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/endpoint_pattern.rb:30 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/checksum_algorithm.rb:137 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/request_compression.rb:94 in `block in call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/request_compression.rb:104 in `with_metric'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/request_compression.rb:94 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/rest/content_type_handler.rb:27 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/express_session_auth.rb:50 in `block in call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/express_session_auth.rb:56 in `with_metric'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/express_session_auth.rb:50 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/expect_100_continue.rb:23 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/bucket_name_restrictions.rb:21 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/rest/handler.rb:10 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/recursion_detection.rb:18 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/endpoints.rb:49 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/endpoint_discovery.rb:84 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/endpoint.rb:46 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/param_validator.rb:26 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/raise_response_errors.rb:16 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/sse_cpk.rb:24 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/dualstack.rb:21 in `call'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/plugins/accelerate.rb:43 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/checksum_algorithm.rb:111 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/jsonvalue_converter.rb:16 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/invocation_id.rb:16 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/idempotency_token.rb:19 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/param_converter.rb:26 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/request_callback.rb:89 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/response_paging.rb:12 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/plugins/response_target.rb:24 in `call'
               |     .../gems/aws-sdk-core-3.201.5/lib/seahorse/client/request.rb:72 in `send_request'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/client.rb:15841 in `put_object'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/object.rb:2656 in `block in put'
               |     .../gems/aws-sdk-core-3.201.5/lib/aws-sdk-core/plugins/user_agent.rb:51 in `metric'
               |     .../gems/aws-sdk-s3-1.159.0/lib/aws-sdk-s3/object.rb:2655 in `put'
               |     app/actions/create.rb:14 in `handle'
```

## Reproduction Steps

1. Start server: `env bucket=your_s3_bucket_name bundle exec hanami server`
2. Run test script: `./test.sh`
3. Boom.
