Rails.application.routes.draw do
  get '/outgoing'=>'posts#outgoing'

  get '/incoming'=>'posts#incoming'

  get 'posts/destroy'

  get 'posts/update'

  get 'posts/index'

  get 'posts/calendar'

  get 'posts/report'

  post 'posts/out'

  post 'posts/in'

  get 'posts/:id'=>'posts#show'

  get 'posts/:id/edit'=>'posts#edit'

  post 'posts/:id/destroy'=>'posts#destroy'

  post 'posts/:id/update'=>'posts#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
