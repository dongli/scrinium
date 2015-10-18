module V1
  class GroupsAPI < Grape::API
    resource :groups do
      desc 'List all groups.'
      get :names do
        Group.all.map { |g| [ g.id, g.name ] }
      end

      desc 'List all groups where a user is in.'
      params do
        requires :user_id, type: Integer, desc: 'User ID.'
      end
      post :for_user do
        User.find(params[:user_id]).memberships
          .select { |x| x.host_type == 'Group' }
          .map { |x| [ x.host.id, x.host.name ] }
      end
    end
  end
end
