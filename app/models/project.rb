class Project < ApplicationRecord

  # Пренадлежит организации
  belongs_to :tenant
  # Должнен иметь уникальное Название
  validates_uniqueness_of :title
  # Имеет множество вложение, наслежует удаление
  has_many :artifacts, dependent: :destroy
  # Имеет множество USERProject
  has_many :user_projects
  # Имеет множестов Пользователей, через зависимость UserProject
  has_many :users, through: :user_projects
  # При создании проверять на " Free план может иметь тольео один проект "
  validate :free_plan_can_only_have_one_project



  # Проверка на то, что план Free может иметь только один проект
  def free_plan_can_only_have_one_project
    # Если создан новый Project и организации уже есть болше 1 проектов  И тариф Free, то добавляем ошибку
    if self.new_record? && (tenant.projects.count > 0) && (tenant.plan == 'free')
      errors.add(:base, "На БЕСПЛАТНОМ тарифе у вас может быть только один проект")
    end
  end

  # Метод возвращает список проектов  Используется в _List вьюхе
  def self.by_user_plan_and_tenant(tenant_id, user)
    tenant = Tenant.find(tenant_id)

    # В тарифе Премиум
    if tenant.plan == 'premium'

      # Если пользователь Админ, то показываем все пректы организации
      if user.is_admin?
        tenant.projects
      else
        # Если не Админ, то только проекты, где он участник
        user.projects.where(tenant_id: tenant.id)
      end
    else
      # В тарифе Free
      if user.is_admin?
        tenant.projects.order(:id).limit(1)
      else
        user.projects.where(tenant_id: tenant.id).order(:id).limit(1)
      end
    end
  end
end
