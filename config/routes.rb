# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboards#protected_route'

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'dashboard' => 'dashboards#index', as: :dashboard
  resources :teams
  resources :projects
end
