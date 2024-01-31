# frozen_string_literal: true

class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:creator).by_user(current_user)
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
