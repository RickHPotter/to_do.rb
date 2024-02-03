import NestedForm from 'stimulus-rails-nested-form'

// Connects to data-controller='nested-form'
export default class extends NestedForm {
  connect() {
    super.connect()
  }

  submit_auto_save(event) {
    event.preventDefault()
    const form = event.target.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement
    this.remove(event)
    form.requestSubmit()
  }
}
