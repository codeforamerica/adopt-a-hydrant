class PromoCodesController < ApplicationController
  respond_to :json

  def update
    return render json: {:errors => ['A user_id must be provided']}, :status => :unauthorized if !params[:promo_code][:user_id]
    @pc = PromoCode.find_by_token(params[:promo_code][:token])
    return render :nothing => true, :status => :not_found if @pc.nil?
    return render json: {:errors => ['That promo code has already been used']}, :status => :unprocessable_entity if @pc.used?
    if @pc.update_attributes(promo_code_params)
      return render json: @pc
    else
      render json: {:errors => @pc.errors}, :status => 500
    end
  end

  def use
    render layout: false
  end

  private
    def promo_code_params
      params.require(:promo_code).permit(:token, :user_id)
    end
end
