class ThingsController < ApplicationController
  respond_to :json

  def show
    if params[:user_id] != nil
      @user = User.find(params[:user_id])
      @things = Thing.find_by_user(current_user)
    else
      @things = Thing.find_closest(params[:lat], params[:lng], params[:limit] || 10)
    end
    
    if @things.blank?
      render(json: {errors: {address: [t('errors.not_found', thing: t('defaults.thing'))]}}, status: 404)
    else
      respond_with @things
    end
  end

  def update
    @thing = Thing.find(params[:id])
    if @thing.update_attributes(thing_params)
      respond_with @thing
    else
      render(json: {errors: @thing.errors}, status: 500)
    end
  end

private

  def thing_params
    params.require(:thing).permit(:name, :user_id)
  end
end
