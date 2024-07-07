import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['cartLink']
  static values = {
    cartUrl: { type: String, default: '/cart_link' }
  }

  async updateCartLink() {
    console.log('Fetching cart URL:', this.cartUrlValue); // Vérification de l'URL

    try {
      const response = await fetch(this.cartUrlValue);
      if (!response.ok) {
        throw new Error(`La réponse du réseau n'est pas valide : ${response.statusText}`);
      }
      this.cartLinkTarget.innerHTML = await response.text();
    } catch (error) {
      console.error('Un problème est survenu lors de l\'opération de récupération :', error);
      this.cartLinkTarget.innerHTML = '<p>Échec du chargement du panier. Veuillez réessayer plus tard.</p>';
    }
  }

  connect() {
    this.updateCartLink();
  }
}
