Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/check_ins/between_dates', to: 'check_ins#between_date_range'
  resources :check_ins
end
