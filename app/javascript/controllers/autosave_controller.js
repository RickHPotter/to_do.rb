import Autosave from 'stimulus-rails-autosave'

// Connects to data-controller='autosave'
export default class extends Autosave {
  static values = {
    delay: {
      type: Number,
      default: 2000,
    },
  }

  connect() {
    super.connect()
  }

  submit_destroy(event) {
    event.target.ParentElement.querySelector("input[name*='_destroy']").value = "1"
  }
}
