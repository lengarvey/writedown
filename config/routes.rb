Writedown::Application.routes.draw do
  resource :article, :only => [ :show, :create ]
end
