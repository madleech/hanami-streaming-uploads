# frozen_string_literal: true

require "logger"
require "aws-sdk-s3"

module Upload
  module Actions
    class Create < Action
      def handle(request, response)
        logger = Logger.new($stdout)
        # ref: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Client.html#initialize-instance_method
        s3_client = Aws::S3::Resource.new(
          region: "ap-southeast-2",
          http_wire_trace: true,
          logger:,
          log_level: :debug,
          retry_limit: 0
        )
        s3_bucket = s3_client.bucket(ENV.fetch("bucket"))
        s3_object = s3_bucket.object("#{SecureRandom.hex(16)}.temp")

        logger.info("Starting to upload to S3, size = #{request.env["CONTENT_LENGTH"].to_i}")

        body = request.env["rack.input"]

        # ref: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Object.html#put-instance_method
        result = s3_object.put(
          body:,
          content_length: request.env["CONTENT_LENGTH"].to_i
        )

        logger.info("Finished S3 upload")

        halt 200, {etag: result.etag, url: s3_object.public_url}.to_json
      end
    end
  end
end