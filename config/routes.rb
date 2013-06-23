Writedown::Application.routes.draw do
  resource :article, :only => [ :show, :create ]

  root :to => 'articles#show'
end
