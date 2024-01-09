Rails.application.routes.draw do
  scope module: :public do
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   get 'top' => 'homes#top'
   get 'about' => 'homes#about'
   root to: 'homes#top'
end
