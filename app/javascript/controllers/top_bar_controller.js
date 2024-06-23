import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['cartLink']
  static values = {
    cartUrl: { type: String, default: Solidus.pathFor('cart_link') }
  }

  async updateCartLink() {
    console.log('Fetching cart URL:', this.cartUrlValue); // Vérification de l'URL

    try {
      const response = await fetch(this.cartUrlValue);
      if (!response.ok) {
        throw new Error(`Network response was not ok: ${response.statusText}`);
      }
      this.cartLinkTarget.innerHTML = await response.text();
    } catch (error) {
      console.error('There was a problem with the fetch operation:', error);
      this.cartLinkTarget.innerHTML = '<p>Failed to load cart. Please try again later.</p>';
    }
  }

  connect() {
    this.updateCartLink();
  }
}
