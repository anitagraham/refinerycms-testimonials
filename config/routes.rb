Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :testimonials do
    resources :testimonials, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :testimonials, :path => '' do
    namespace :admin, :path => 'refinery/testimonials' do
      resources :testimonials, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
