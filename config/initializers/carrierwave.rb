CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAJ2MKDTKR2K5E2K4Q",
    aws_secret_access_key: "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"
  }
  config.fog_directory = "elasticbeanstalk-us-west-2-111956727610"
end