class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_and_collectable, except: [:toggle_watched]

  def collect
    @collection = @user.collections.new(collection_params)
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

  private

  def load_user_and_collectable
    user_id, resource, collectable_id = request.path.split('/')[2,4]
    @user = User.find(user_id)
    @collectable = resource.singularize.classify.constantize.find(collectable_id)
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
                                       :watched)
  end
end
