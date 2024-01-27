# frozen_string_literal: true

class DashboardsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index; end

  def protected_route; end
end
