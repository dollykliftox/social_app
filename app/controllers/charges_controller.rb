# frozen_string_literal: true

class ChargesController < ApplicationController
  def new; end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create({
                                         email: params[:stripeEmail],
                                         source: params[:stripeToken],
                                         shipping: {
                                           name: params[:stripeShippingName],
                                           address: {
                                             line1: params[:stripeShippingAddressLine1],
                                             postal_code: params[:stripeShippingAddressZip],
                                             city: params[:stripeShippingAddressCity],
                                             state: params[:stripeShippingAddressState],
                                             country: params[:stripeShippingAddressCountry]
                                           }
                                         }
                                       })

    charge = Stripe::Charge.create({
                                     customer: customer.id,
                                     amount: @amount,
                                     description: 'Rails Stripe customer',
                                     currency: 'inr'
                                   })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
