class AngularController < ApplicationController

  before_action :render_layout_if_html
  respond_to :json, :html

  private 
    def render_layout_if_html
      if request.format.symbol == :html
        render 'layouts/application'
      end
    end
end