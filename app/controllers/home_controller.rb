class HomeController < ApplicationController
  def index
  end

  def new_round
  end

  private
  def home_params
    params.require(:home).permit(:collection_id, :participant_id,)
  end
end
