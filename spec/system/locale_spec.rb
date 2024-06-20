# frozen_string_literal: true

require 'solidus_starter_frontend_spec_helper'

RSpec.describe 'setting locale', type: :system do
  include_context 'featured products'

  before do
    I18n.backend.store_translations(:fr, spree: {
      i18n: { this_file_language: "Français" },
      cart: 'Panier',
      shopping_cart: 'Panier',
      add_to_cart: 'Ajouter au panier', # Ajout de la traduction manquante
      my_cart: 'Mon panier',
      my_account: "Mon compte",
      name: 'Nom',
      address: 'Adresse',
      city: 'Ville',
      country: 'Pays',
      state: 'État',
      zip: 'Code postal',
      phone: 'Téléphone',
      email: 'Email',
      password: 'Mot de passe',
      password_confirmation: 'Confirmation du mot de passe',
      create_account: 'Créer un compte',
      login: 'Connexion',
      logout: 'Déconnexion',
      forgot_password: 'Mot de passe oublié',
      reset_password: 'Réinitialiser le mot de passe',
      new_password: 'Nouveau mot de passe',
      confirm_password: 'Confirmer le mot de passe',
      back_to_store: 'Retour à la boutique',
      cancel: 'Annuler',
      edit: 'Modifier',
      delete: 'Supprimer',
      save: 'Enregistrer',
      update: 'Mettre à jour',
      search: 'Rechercher',
      search_results: 'Résultats de la recherche',
      no_results: 'Aucun résultat',
      address_book: 'Carnet d\'adresses',
      credit_card: 'Carte de crédit',
      shipping_method: 'Méthode d\'expédition',
      billing_address: 'Adresse de facturation',
      shipping_address: 'Adresse de livraison',
      shipping: 'Expédition',
      payment: 'Paiement',
      confirm: 'Confirmer',
      confirm_order: 'Confirmer la commande',
      order_total: 'Total de la commande',
      subtotal: 'Sous-total',
      shipping_total: 'Total de l\'expédition',
      payment_total: 'Total du paiement',
      order_summary: 'Résumé de la commande',
      order_details: 'Détails de la commande',
      order_number: 'Numéro de commande',
      order_date: 'Date de commande',
      order_status: 'Statut de la commande',
      order_items: 'Articles de commande',
      order_notes: 'Notes de commande',
      order_history: 'Historique des commandes',
      order_history_empty: 'Vous n\'avez pas encore passé de commande.',
      order_canceled: 'Commande annulée',
      order_canceled_message: 'Votre commande a été annulée.',
      order_canceled_message_with_reason: 'Votre commande a été annulée pour la raison suivante : %{reason}.',
      order_canceled_message_with_no_reason: 'Votre commande a été annulée.',
      order_completed: 'Commande terminée',
      order_completed_message: 'Votre commande a été terminée avec succès.',
      order_completed_message_with_details: 'Votre commande a été terminée avec succès. Vous pouvez consulter les détails de votre commande ci-dessous.',
      

    })
    I18n.locale = :fr # assurez-vous que la locale est définie sur :fr
  end

  let!(:store) { create(:store) }
  def with_locale(locale)
    I18n.locale = locale
    yield
  ensure
    I18n.locale = I18n.default_locale
  end

  context 'shopping cart link and page' do
    include_context "fr locale"

    it 'should be in french' do
      with_locale('fr') do
        visit root_path
        click_link 'Panier'
        expect(page).to have_content('Panier')
      end
    end
  end
end
