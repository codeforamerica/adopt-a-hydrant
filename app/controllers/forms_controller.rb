class FormsController < ApplicationController
  def index
    @hydrant = Hydrant.find_by_id(params[:hydrant_id])
    if @hydrant.adopted?
      if user_signed_in? && current_user.id == @hydrant.user_id
        render(:partial => "thank_you")
      else
        render(:partial => "user_profile")
      end
    else
      if user_signed_in?
        render(:partial => "adoption_form")
      else
        render(:partial => "combo_form")
      end
    end
  end
end
