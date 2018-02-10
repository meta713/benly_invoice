Rails.application.routes.draw do
  get 'test/index'
  get 'test/test'
  get 'test/hoge'
  get 'test/fuga'

  namespace :management do
    get '' => 'orders#index'
    resources :orders do
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
