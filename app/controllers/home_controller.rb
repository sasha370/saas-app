class HomeController < ApplicationController
  skip_before_action :authenticate_tenant!, :only => [:index]

  def index
    # Если пользователь зарегистрирован, то
    if current_user


      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end

      # В переменную записываем Текущую фирму
      @tenant = Tenant.current_tфирму
      # И записываем списвок проектов из Контроллера Project, чтобы его отобразить на странице
      @projects = Project.by_user_plan_and_tenant(@tenant.id, current_user)

      params[:tenant_id] = @tenant.id
    end
  end

end
