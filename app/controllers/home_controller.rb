class HomeController < ApplicationController
  def index
  end

  def new_participant_session
    # @participant = User::Participant.find(params[:participant_id])
    # @collection = Collection.find(params[:collection_id])
  end

  private
  def home_params
    params.require(:home).permit(:collection_id, :participant_id,)
  end
end
