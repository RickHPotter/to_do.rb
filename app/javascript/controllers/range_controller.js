import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  connect() { }

  update(event) {
    const value = event.target.value
    const target = event.target
    const step = value / 25
    const colours = ['range-error', 'range-warning', 'range-info', 'range-success']

    target.classList.remove(...colours)
    if (step > 0) {
      target.classList.add(colours[step - 1])
    }
  }
}
