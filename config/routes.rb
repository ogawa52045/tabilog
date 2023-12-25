Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
    
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   get 'top' => 'homes#top'
   get 'about' => 'homes#about'
   root to: 'homes#top'
end
