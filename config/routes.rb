Writedown::Application.routes.draw do
  resource :article, :only => [ :show, :create ] do
    member do
      post :save
    end
  end

  root :to => 'articles#show'
end
