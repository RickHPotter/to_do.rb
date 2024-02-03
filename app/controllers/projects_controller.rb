# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_teams, only: %i[new create edit update]
  before_action :set_helpers, except: %i[show destroy]

  def index
    @projects = Project.all.includes([:tasks]).order(:created_at)
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        flash[:notice] = t('notification.created', model: t('activerecord.models.project.one'))
        format.html { redirect_to project_url(@project) }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        flash[:notice] = t('notification.updated', model: t('activerecord.models.project.one'))
      else
        flash[:alert] = t('notification.not_updated', model: t('activerecord.models.project.one'))
      end
      format.turbo_stream
    end
  end

  def destroy
    @project.destroy!

    if @project.destroyed?
      flash[:notice] = t('notification.destroyed', model: t('activerecord.models.project.one'))
    else
      flash[:alert] = t('notification.not_destroyed', model: t('activerecord.models.project.one'))
    end

    respond_to do |format|
      format.html { redirect_to projects_url }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_teams
    @teams = current_user.teams.pluck(:team_name, :id)
  end

  def set_helpers
    @users = User.where.not(id: current_user.id).pluck(:first_name, :id)
    @priorities = Project.priorities.keys
  end

  def project_params
    params.require(:project).permit(
      :project_name, :description, :progress, :priority, :due_date, :team_id, :creator_id,
      tasks_attributes: %i[id task_name description order progress priority due_date assignee_id _destroy]
    )
  end
end
