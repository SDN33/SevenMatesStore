# config/routes.rb

Rails.application.routes.draw do
  mount SolidusAdmin::Engine, at: '/admin', constraints: ->(req) {
    req.cookies['solidus_admin'] != 'false' &&
    req.params['solidus_admin'] != 'false'
  }
  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'
  scope(path: '/') { draw :storefront }

  mount Spree::Core::Engine, at: '/'

  # Add the route for checkout/address
  get '/checkout/address', to: 'checkout#address', as: 'checkout_address'
  get '/checkout/delivery', to: 'checkout#delivery', as: 'checkout_delivery'
  get '/checkout/payment', to: 'checkout#payment', as: 'checkout_payment'
  get '/checkout/confirm', to: 'checkout#confirm', as: 'checkout_confirm'
  get '/checkout/complete', to: 'checkout#complete', as: 'checkout_complete'

  # Other routes...
end
