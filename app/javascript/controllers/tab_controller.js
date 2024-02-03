import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ['tab']

  connect() { }

  toggle(event) {
    const tab = event.currentTarget
    this.perform(tab)
  }

  perform(current_target) {
    const tabs = this.tabTargets

    const inactive_class = ['border-transparent', 'hover:text-indigo-700', 'hover:border-indigo-700']
    const active_class = ['active', 'text-blue-600', 'border-blue-600']

    tabs.forEach((t) => {
      t.classList.remove(...active_class)
      t.classList.add(...inactive_class)
    })

    current_target.classList.remove(...inactive_class)
    current_target.classList.add(...active_class)
  }

}
