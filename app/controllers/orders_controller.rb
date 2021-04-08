# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :paypal_init, except: [:index]

  def index; end

  def create_order
    # PAYPAL CREATE ORDER
    debugger
    price = '100.00'
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest.new
    request.request_body({
                           intent: 'CAPTURE',
                           purchase_units: [
                             {
                               amount: {
                                 currency_code: 'INR',
                                 value: price
                               }
                             }
                           ]
                         })
    begin
      response = @client.execute request
      order = Order.new
      order.price = price.to_i
      order.token = response.result.id
      render json: { token: response.result.id }, status: :ok if order.save
    rescue PayPalHttp::HttpError => e
      # HANDLE THE ERROR
    end
  end

  def capture_order
    # PAYPAL CAPTURE ORDER
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new params[:order_id]
    begin
      response = @client.execute request
      order = Order.find_by token: params[:order_id]
      order.paid = response.result.status == 'COMPLETED'
      render json: { status: response.result.status }, status: :ok if order.save
    rescue PayPalHttp::HttpError => e
      # HANDLE THE ERROR
    end
  end

  private

  def paypal_init
    client_id = 'AaYwR708alPMHnzlM1D0JKpjhuk-EA3cPo7eG8GWBZYVSr5IVS8Ap4f7UasWhYGAKqdi-bgJ2NZ_IIQw'
    client_secret = 'ECOXC089UTK1OfTIjzJWWwEYhbR4Q5SKRc2NY3aU4FuRS5-fickznM9DtE4FpqhC3EZlBkvGjfT30O2_'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
