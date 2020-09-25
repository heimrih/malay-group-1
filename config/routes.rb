Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    root "posts#index"
    get "notifications/:id/link_through", to: "notifications#link_through", as: :link_through
    get "notifications", to: "notifications#index"
    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
    get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
    get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :posts do
      resources :comments
      resources :activities
    end
    resources :conversations do
      member do
        post :reply
        post :trash
        post :untrash
      end
    end
    resources :notifications, only: :edit
  end
end
