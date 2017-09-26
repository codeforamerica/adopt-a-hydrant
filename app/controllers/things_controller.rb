class ThingsController < ApplicationController
  respond_to :json

  def show
    @things = Thing.find_closest(params[:lat], params[:lng], params[:limit] || 10)
    if @things.blank?
      render(json: {errors: {address: [t('errors.not_found', thing: t('defaults.thing'))]}}, status: 404)
    else
      respond_with @things
    end
  end

  def update
    @thing = Thing.find(params[:id])
    if @thing.update_attributes(thing_params)
      send_adoption_email(@thing.user, @thing) if @thing.adopted?

      respond_with @thing
    else
      render(json: {errors: @thing.errors}, status: 500)
    end
  end

private

  def send_adoption_email(user, thing)
    case user.things.count
    when 1
      ThingMailer.first_adoption_confirmation(thing).deliver_later
    when 2
      ThingMailer.second_adoption_confirmation(thing).deliver_later
    end
  end

  def thing_params
    params.require(:thing).permit(:adopted_name, :user_id)
  end
end
