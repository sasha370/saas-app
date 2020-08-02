
class HomeController < ApplicationController
  # Скипнуть аутентифацию для этого контролера в Index
  skip_before_action :authenticate_tenant!, :only => [ :index ]


  # Домашняя страница для Организации
  def index
    # Если пользователь вошел
    if current_user

      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      # Организация = текущая организация
      @tenant = Tenant.current_tenant
      # Проекты = все проекты текущей организации ( метод прописан в модели Project)
      @projects = Project.by_user_plan_and_tenant(@tenant.id, current_user)

      params[:tenant_id] = @tenant.id
    end
  end
end
