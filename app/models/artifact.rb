class Artifact < ApplicationRecord

  attr_accessor :upload

  belongs_to :project

  MAX_FILESIZE = 10.megabytes
  # Проверяем наличие названия и файла для загрузки
  validates_presence_of :name,загрузки
  # проверяем уникальность имени
  validates_uniqueness_of :name
  # Проверяем размер загруженного файла
  validate :upload_file_size


  private

  # ДО тех пор пока размер файла превышает MAX_FILESIZE, добавляем ошибку в общий список
  def upload_file_size
    errors.add(:upload, "Размер файла не должен превышать #{self.class::MAX_FILESIZE} ") unless  upload.size <= self.class::MAX_FILESIZE
  end
end
