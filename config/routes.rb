Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Custom routes for ActiveAdmin
  namespace :sudo do
    root to: redirect('/sudo/collections'), as: :redirect_sudo_root

    resources :packages, constraints: { id: /[^\/]+(?<!\.json)/ } # Allow dots in ID

    resources :collections do
      get ":state", action: :index, as: "state", on: :collection
    end
  end

  ActiveAdmin.routes(self)

  root to: redirect('https://js.coach')

  get "*path", to: "application#smo_prerender"
end
