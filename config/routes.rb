# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'dashboards#index'
  devise_for :users

  get 'dashboard' => 'dashboards#index', as: :dashboard
  get 'protected_route' => 'dashboards#protected_route', as: :protected
  get 'up' => 'rails/health#show', as: :rails_health_check
end
