class DashboardController < ApplicationController
  before_action :authenticate_admin!

  AdminModels = %w[users articles groups topics].freeze

  def index
    redirect_to admin_users_path
  end

  AdminModels.each do |category|
    self.class_eval <<-EOT
      def admin_#{category}
        @category = '#{category}'
        @search = #{category.singularize.classify.constantize}.search(params[:q])
        @#{category} = @search.result.order(:id).page(params[:page])
      end
    EOT
  end
end
