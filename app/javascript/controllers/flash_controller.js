import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  dismiss() {
    this.element.parentNode.removeChild(this.element)
  }
}
