Rails.application.routes.draw do
  root to: 'home#index', as: :storefront_root

  mount SolidusAdmin::Engine, at: '/admin', constraints: ->(req) {
    req.cookies['solidus_admin'] != 'false' &&
    req.params['solidus_admin'] != 'false'
  }
  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'
  scope(path: '/') { draw :storefront }

  mount Spree::Core::Engine, at: '/' # Change the root for Spree

  # Routes for checkout process
  get '/checkout/address', to: 'checkout#address', as: 'checkout_address'
  get '/checkout/delivery', to: 'checkout#delivery', as: 'checkout_delivery'
  get '/checkout/payment', to: 'checkout#payment', as: 'checkout_payment'
  get '/checkout/confirm', to: 'checkout#confirm', as: 'checkout_confirm'
  get '/checkout/complete', to: 'checkout#complete', as: 'checkout_complete'

  # Custom routes
  get '/list-products', to: 'products#index', as: 'list_products'
  get '/pages/_matesclubform', to: 'pages#matesclubform', as: 'matesclubform_page'
  get '/matesclubform', to: 'pages#matesclubform', as: 'matesclubform'
  get '/pages/_apropos', to: 'pages#apropos', as: 'apropos_page'
  get '/contact', to: 'pages#contact', as: 'contact'

end
