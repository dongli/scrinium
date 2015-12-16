class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_collectable, except: [ :toggle_watched, :view ]

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
      end
    end
  end

  def view
    @collection = Collection.find(params[:id])
    if @collection.updated
      @collection.updated = false
      @collection.save!
    end
    respond_to do |format|
      format.html { redirect_to @collection.collectable }
    end
  end

  private

  def load_collectable
    # /<collectable_type>/:id/<collect|uncollect>/...
    collectable_type, collectable_id = request.path.split('/')[1..2]
    collectable_type = collectable_type.singularize.classify
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
