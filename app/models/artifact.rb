class Artifact < ApplicationRecord
  require 'aws-sdk'
  attr_accessor :upload

  belongs_to :project
  before_save :upload_to_s3

  MAX_FILESIZE = 10.megabytes
  # Проверяем наличие названия и файла для загрузки
  validates_presence_of :name, :upload
  # проверяем уникальность имени
  validates_uniqueness_of :name
  # Проверяем размер загруженного файлаyy
  validate :upload_file_size


  private

  # ДО тех пор пока размер файла превышает MAX_FILESIZE, добавляем ошибку в общий список
  def upload_file_size
    errors.add(:upload, "Размер файла не должен превышать #{self.class::MAX_FILESIZE} ") unless upload.size <= self.class::MAX_FILESIZE
  end

  def upload_to_s3
    s3 = Aws::S3::Resource.new(region:'us-east-1')
    tenant_name = Tenant.find(Thread.current[:tenant_id]).name
    obj = s3.bucket(ENV['AWS_BUCKET']).object("#{tenant_name}/#{upload.original_filename}")
    obj.upload_file(upload.path, acl: 'public-read')
    self.key = obj.public_url
  end

end
