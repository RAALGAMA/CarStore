class CheckoutController < ApplicationController
  def create
    @car = Car.find(params[:car_id])

    return redirect_to root_path if @car.nil?

    # Obtener la cantidad del carrito
    quantity = params[:quantity].to_i || 1

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
          quantity: quantity
        },
        {
          price: gst_price.id,
          quantity: quantity
        }
      ]
    )

     # Limpiar el carrito después de la compra
     session[:shopping_cart] = []

    # Inside the create action
    respond_to do |format|
      format.html { redirect_to @session.url, allow_other_host: true }
      format.js # render app/views/checkout/create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    if @session.payment_intent.present?
      # Recuperar el PaymentIntent asociado a la sesión
      @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

      # Verificar si hay información de dirección en el objeto customer_details
      if @session.customer_details.present? && @session.customer_details[:address].present?
        address_info = @session.customer_details[:address]

        # Crear o actualizar el usuario en tu base de datos con la información de dirección
        #current_user.update(
        #  country: address_info[:country],
        #  state: address_info[:state],
          # Otros campos de dirección...
        #)
      end

      # Extraer la información de los productos comprados
      if @payment_intent.invoice.present? && @payment_intent.invoice.items.present?
        invoice_items = @payment_intent.invoice.items.data

        # Crear un nuevo pedido en tu base de datos
        order = Order.create(
          user_id: current_user.id,
          total_amount: @payment_intent.amount / 100,
          status: 'pending'
        )

        # Iterar sobre los productos comprados y guardar en la tabla order_items
        invoice_items.each do |item|
          product_info = "#{car.model} - #{car.brand}"
          OrderItem.create(
            order_id: order.id,
            product_info: product_info,
            quantity: quantity,
            price: price
          )
        end
      else
        Rails.logger.error("No se encontró información de factura o productos en el PaymentIntent")
      end

    else
      Rails.logger.error("No se encontró un PaymentIntent asociado a la sesión de Stripe")
    end
  end

  def cancel
  end
end
