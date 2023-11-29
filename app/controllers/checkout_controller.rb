class CheckoutController < ApplicationController
  def create
    @car = Car.find(params[:car_id])

    return redirect_to root_path if @car.nil?

    # Create product and price for the main item (car)
    car_product = Stripe::Product.create(
      name: @car.model,
      description: @car.brand
    )

    main_price = Stripe::Price.create(
      product: car_product.id,
      unit_amount: (@car.price * 100).to_i, # Multiplica por 100 para convertir a centavos
      currency: 'cad'
    )

    # Create product and price for the additional item (GST)
    gst_product = Stripe::Product.create(
      name: 'GST',
      description: 'Good and Service Tax'
    )

    gst_price = Stripe::Price.create(
      product: gst_product.id,
      unit_amount: (@car.price * 0.05 * 100).to_i, # Multiplica por 100 para convertir a centavos
      currency: 'cad'
    )

    # Create Checkout Session
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      line_items: [
        {
          price: main_price.id,
          quantity: 1
        },
        {
          price: gst_price.id,
          quantity: 1
        }
      ]
    )

    # Inside the create action
    respond_to do |format|
      format.html { redirect_to @session.url, allow_other_host: true }
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
  end
end
