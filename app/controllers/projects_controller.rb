class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # Перед всеми экшенами над Project нам нужно выбрать Организацию
  before_action :set_tenant, only: [:show, :edit, :update, :destroy, :new, :create]
  # Перед любым действием нам надо убедится, что Данные проект принадлежит именно даннной Организации
  before_action :verify_tenant


  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to root_url, notice: 'Project was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_url, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Project was successfully destroyed.' }
     end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:title, :details, :expected_completion, :tenant_id)
  end


  # Ищем Организацию по переданному в параметрах ID
  def set_tenant
    @tenant = Tenant.find(params[:tenant_id])
  end

  # До тех порк пока Текущая организация небудет совпадать с переданной, перенаправляем и сообщаем ощибку
  def verify_tenant
    unless params[:tenant_id] == Tenant.current_tenant_id.to_s
      redirect_to :root, flash: { error: "Вы не можете просматривать проекты других организаций" }
    end
  end

end
