Rails.application.routes.draw do
# Put your extension routes here.

  namespace :admin do
    resources :taxons do
      member do
        put :reorder_products
      end
    end  
  end
end
# map.namespace :admin do |admin|
#   admin.resources :whatever
# end  
