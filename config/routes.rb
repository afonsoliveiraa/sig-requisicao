Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :attests, only: [:create], path: 'api/v1/attest'
  get 'api/v1/attest/:token', to: 'attests#response_attest'

  # Aceite via link único (GET /attest/:token)
  get 'attest/:combined_tokens', to: 'attests#index', as: :attest_accept
  # Atualização de assinatura (PATCH /signatures/update)
  patch 'signatures/:id/update', to: 'signatures#update_status', as: :update_status_signature

end
