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
        Group.joins(:group_user_associations)
          .where("group_user_associations.user_id = #{params[:user_id]}")
          .map { |g| [ g.id, g.name ] }
      end
    end
  end
end
