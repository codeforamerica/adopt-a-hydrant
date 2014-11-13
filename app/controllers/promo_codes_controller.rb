class PromoCodesController < ApplicationController
  respond_to :json

  def update
    promo_code = find_promo_code

    unless promo_code
      return render json: {errors: ['Promo Code not found']},
        status: :not_found
    end

    unless promo_code_params[:user_id]
      return render json: {errors: ['A user_id must be provided']},
        status: :unauthorized
    end

    if promo_code.used?
      return render json: {errors: ['That promo code has already been used']},
        status: :forbidden
    end

    if promo_code.update(promo_code_params)
      render json: promo_code
    else
      render json: {errors: promo_code.errors},
        status: :unprocessable_entity
    end
  end

  def use
    render layout: false
  end

  private

  def promo_code_params
    params.require(:promo_code).permit(:token, :user_id)
  end

  def find_promo_code
    PromoCode.find_by(token: promo_code_params[:token])
  end
end
