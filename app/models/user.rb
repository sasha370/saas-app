class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable,  :validatable

  # Использовать кау основной Акк для Milia
  acts_as_universal_and_determines_account
  # Имеет одного Зарегистрированного, наследует Удаление
  has_one :member, :dependent => :destroy
  # User имеет множество взаимосвязей UserПроект
  has_many :user_projects
  # User имеет множество проектов, через UserПроект
  has_many :projects, through: :user_projects
  # Имеют один Платеж, делят некоторые атрибуты с Платежем
  has_one :payment
  accepts_nested_attributes_for :payment


# Проверяем админ ли пользователь? Возвращает true /false
  def self.is_admin?
    is_admin
  end

end
