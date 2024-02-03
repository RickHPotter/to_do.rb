import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ['input']

  connect() { this.update_colour(this.inputTarget) }

  update(event) {
    this.update_colour(event.target)
  }

  update_colour(element) {
    const value = element.value
    const step = value / 25
    const colours = ['bg-red-700', 'bg-yellow-400', 'bg-indigo-600', 'bg-green-500']

    element.classList.remove(...colours)
    if (step > 0) {
      element.classList.add(colours[step - 1])
    }
  }
}
