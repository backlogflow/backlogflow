class BoardController < ApplicationController
  respond_to :html, :js, :json
  
  def show
     logger.debug "Entrei"
  end
end
