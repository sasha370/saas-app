class Artifact < ApplicationRecord

  attr_accessor :upload
  belongs_to :project

  before_save :upload_to_s3

  MAX_FILESIZE = 10.megabytes

  validates_presence_of :name, :upload
  validates_uniqueness_of :name
  validate :upload_file_size

  private

  def upload_file_size
    errors.add(:upload, "Размер файла не должен превышать #{self.class::MAX_FILESIZE} ") unless upload.size <= self.class::MAX_FILESIZE
  end

  def upload_to_s3
    s3 = Aws::S3::Resource.new(region:'us-east-1',
                               access_key_id: (ENV['AWS_ACCESS_KEY_ID'] ||= Rails.application.credentials.aws[:access_key_id]),
                               secret_access_key: (ENV['AWS_SECRET_ACCESS_KEY'] ||= Rails.application.credentials.aws[:secret_access_key]) )
    tenant_name = Tenant.find(Thread.current[:tenant_id]).name
    obj = s3.bucket('saasfile').object("#{tenant_name}/#{upload.original_filename}")
    obj.upload_file(upload.path, acl: 'public-read')
    self.key = obj.public_url
  end
end
