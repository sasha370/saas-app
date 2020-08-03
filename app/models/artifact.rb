class Artifact < ApplicationRecord

  attr_accessor :upload
  # Принадлежит Project
  belongs_to :project
  # Перед сохранение в БД сделать загрузку на сервер s3
  before_save :upload_to_s3

  # Максимальный размер загружаемого файла
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
    # создаем новый ресурс для загрузки на s3
    s3 = Aws::S3::Resource.new(region:'us-east-1',
                               access_key_id: Rails.application.credentials.aws[:access_key_id],
                               secret_access_key:  Rails.application.credentials.aws[:secret_access_key] )
    # создаем имя для файла = имя Организации
    tenant_name = Tenant.find(Thread.current[:tenant_id]).name

    # создаем объект на сервере, для каждой организации в своей папке
    obj = s3.bucket('saasfile').object("#{tenant_name}/#{upload.original_filename}")


    obj.upload_file(upload.path, acl: 'public-read')
    # присваимем key адрес ссылки
    self.key = obj.public_url
  end

end
