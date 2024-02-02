# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  def index
    @teams = Team.by_user(current_user)
  end

  def show; end

  def new
    @team = Team.new(creator: current_user)
    @policies = Team.policies.map { |k, _v| [k.capitalize, k] }
  end

  def create
    @team = Team.new(team_params.merge(creator: current_user))

    respond_to do |format|
      if @team.save
        flash[:notice] = 'Team was successfully created.'
        # FIXME: add admin to params so that this does not get hardcoded
        TeamUser.create(team: @team, user: current_user, admin: false)
        format.html { redirect_to team_path(@team) }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_team
    @team = Team.includes(:creator).find(params[:id])
  end

  def team_params
    params.require(:team).permit(:team_name, :description, :creator_id, :policy)
  end
end
