class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_app_and_collectable, except: [ :toggle_watched, :view ]

  def collect
    @collection = current_user.collections.new(collection_params)
    respond_to do |format|
      if @collection.save!
        # NOTE: 需要和environment.rb中的回调函数保持一致！
        MessageBus.subscribe "/update-#{CollectionsHelper.class_escape @collectable}-#{@collectable.id}" do |msg|
          collectable_type, collectable_id = msg.channel.split('-')[1,2]
          collection = current_user.collections.find_by_collectable_id_and_collectable_type(
            collectable_id.to_i, collectable_type
          )
          collection.updated = true
          collection.save!
        end
        format.js
      end
    end
  end

  def uncollect
    @collection = current_user.collections.find_by_collectable_id_and_collectable_type(
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
      format.html { redirect_to [ app, @collection.collectable ] }
    end
  end

  private

  def load_app_and_collectable
    # [/<engine prefix>]/<collectable_type>/:id/<collect|uncollect>/...
    tokens = request.path.split('/').reject(&:empty?)
    n = tokens.index('collect') || tokens.index('uncollect')
    collectable_type, collectable_id = tokens[n-2..n-1]
    if RailsEnginesHelper.engine_names.index { |x| x =~ /_#{tokens.first}$/ }
      app_name = Rails.app_class.to_s.split('::').first
      collectable_type = app_name+tokens.first.capitalize+'::'+collectable_type.singularize.classify
    else
      collectable_type = collectable_type.singularize.classify
    end
    @collectable = collectable_type.constantize.find(collectable_id)
  end

  def collection_params
    params[:collection] = {
      user_id: current_user.id,
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
