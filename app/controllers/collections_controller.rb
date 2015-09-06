class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_and_collectable, except: [:toggle_watched, :view]

  def collect
    @collection = @user.collections.new(collection_params)
    # NOTE: 需要和environment.rb中的回调函数保持一致！
    MessageBus.subscribe "/update-#{CollectionsHelper.class_escape @collectable}-#{@collectable.id}" do |msg|
      collectable_type, collectable_id = msg.channel.split('-')[1,2]
      collection = current_user.collections.find_by_collectable_id_and_collectable_type(
        collectable_id.to_i, collectable_type
      )
      collection.updated = true
      if not collection.save
        # TODO: 处理错误。
      end
    end
    respond_to do |format|
      if @collection.save
        format.js
      else
        # TODO: 处理错误！
      end
    end
  end

  def uncollect
    @collection = @user.collections.find_by_collectable_id_and_collectable_type(
      @collectable.id, @collectable.class
    )
    MessageBus.unsubscribe "/update-#{CollectionsHelper.class_escape @collectable}-#{@collectable.id}"
    @collection.destroy
    respond_to do |format|
      format.js
    end
  end

  def toggle_watched
    @collection = Collection.find(params[:id])
    @collection.watched = !@collection.watched
    respond_to do |format|
      if @collection.save
        format.js
      else
        # TODO: 处理错误。
      end
    end
  end

  def view
    @collection = Collection.find(params[:id])
    if @collection.updated
      @collection.updated = false
      if not @collection.save
        # TODO: 处理错误。
      end
    end
    respond_to do |format|
      # 因为collectable对象可能位于其它engine。如果是，那么需要用该engine的路由器。
      match = @collection.collectable_type.match('(\w+)::')
      app = match ? eval(match[1].underscore) : main_app
      format.html { redirect_to app.url_for([@collection.collectable.user, @collection.collectable]) }
    end
  end

  private

  def load_user_and_collectable
    user_id, collectable_type, collectable_id = request.path.match(/\/users\/(\d+)\/(\w+)\/(\d+)/)[1,3]
    # NOTE: 这里要求所有engine命名规则为<主应用名><子应用名>，并且挂在路径为'/<子应用名>'。
    engine = request.path.match(/^\/(\w+)/)[1]
    if engine != 'users'
      collectable_type = Rails.app_class.to_s.split('::').first+engine.capitalize+'::'+collectable_type.singularize.classify
    end
    @user = User.find(user_id)
    @collectable = collectable_type.constantize.find(collectable_id)
  end

  def collection_params
    params[:collection] = {
      user_id: @user.id,
      collectable_id: @collectable.id,
      collectable_type: @collectable.class.to_s
    }
    params.require(:collection).permit(:user_id,
                                       :collectable_id,
                                       :collectable_type,
                                       :watched,
                                       :updated)
  end
end
