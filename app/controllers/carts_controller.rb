# frozen_string_literal: true

class CartsController < StoreController
  helper 'spree/products', 'orders'

  respond_to :html

  before_action :store_guest_token
  before_action :assign_order, only: :update
  around_action :lock_order, only: :update

  # Shows the current incomplete order from the session
  def show
    @order = current_order(build_order_if_necessary: true)
    authorize! :edit, @order, cookies.signed[:guest_token]

    # Ensure the order number matches the parameter `id`
    if (params[:id] && @order.number) != params[:id]
      flash[:error] = t('Nous ne pouvons pas accéder à cette commande.')
      redirect_to cart_path
    end
  end

  # Updates the order (e.g., adds or removes items)
  def update
    authorize! :update, @order, cookies.signed[:guest_token]

    # Update the order contents based on parameters
    if @order.contents.update_cart(order_params)
      # Proceed to checkout if requested and the order is in the cart state
      if params.key?(:checkout) && @order.cart?
        redirect_to checkout_state_path(@order.checkout_steps.first)
      else
        redirect_to cart_path
      end
    else
      render action: :show
    end
  end

  # Empties the current order (shopping cart)
  def empty
    if @order = current_order
      authorize! :update, @order, cookies.signed[:guest_token]
      @order.empty!
    end

    redirect_to cart_path
  end

  private

  # Sets the title for the cart page
  def accurate_title
    t('shopping_cart')
  end

  # Stores the guest token in a cookie if provided in params
  def store_guest_token
    cookies.permanent.signed[:guest_token] = params[:token] if params[:token]
  end

  # Defines which attributes of the order can be modified
  def order_params
    if params[:order]
      params[:order].permit(*permitted_order_attributes)
    else
      {}
    end
  end

  # Assigns the current order to @order, redirecting if not found
  def assign_order
    @order = current_order
    unless @order
      flash[:error] = t('Votre commande ne peut pas être trouvée.')
      redirect_to(root_path) && return
    end
  end
end
