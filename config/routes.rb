Rails.application.routes.draw do

  scope module: :public do
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :members, only: [:show, :edit, :update] do
      collection do
        get 'check'
        patch 'withdraw'
      end
    end
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  devise_scope :member do
    get 'login', to: 'public/sessions#new'
  end
  
  devise_scope :member do  
    get 'register', to: 'public/registrations#new'
  end

  get 'top' => 'homes#top'
  get 'about' => 'homes#about'
  root to: 'homes#top'

end
