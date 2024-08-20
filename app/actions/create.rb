# frozen_string_literal: true

require "aws-sdk-s3"

module Upload
  module Actions
    class Create < Action
      def handle(request, response)
        s3_client = Aws::S3::Resource.new(region: "ap-southeast-2")
        s3_bucket = s3_client.bucket(ENV.fetch("bucket"))
        s3_object = s3_bucket.object("#{SecureRandom.hex(16)}.temp")

        # ref: https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Object.html#put-instance_method
        result = s3_object.put(
          body: request.env["rack.input"],
          content_length: request.env["CONTENT_LENGTH"].to_i
        )

        halt! 200, result.to_json
      end
    end
  end
end