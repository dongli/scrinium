CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = Settings.qiniu.access_key
  config.qiniu_secret_key    = Settings.qiniu.secret_key
  config.qiniu_bucket        = Settings.qiniu.default_bucket
  config.qiniu_bucket_domain = Settings.qiniu.default_bucket_domain
  config.qiniu_bucket_private= false #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"

  # config.qiniu_up_host       = 'http://up.qiniug.com' #七牛上传海外服务器,国内使用可以不要这行配置
end