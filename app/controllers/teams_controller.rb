# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]
  before_action :set_helpers, only: %i[new create edit update]

  def index
    @teams = current_user.teams
  end

  def show; end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      flash[:notice] = 'Team was successfully created.' if @team.save
      format.turbo_stream
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_team
    @team = Team.includes(:creator).find(params[:id])
  end

  def set_helpers
    @policies = Team.policies.keys
    @users = User.where.not(id: current_user.id).pluck(:first_name, :id)
    @teams = current_user.teams
  end

  def team_params
    params.require(:team).permit(
      :team_name, :description, :creator_id, :policy,
      team_users_attributes: %i[id user_id admin _destroy]
    )
  end
end
