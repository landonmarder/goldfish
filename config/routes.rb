Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"

  resources :groups, only: [:index, :show] do
    resources :memberships, only: [:index, :destroy]
    resources :group_activities, only: [:index, :create]
  end
end
