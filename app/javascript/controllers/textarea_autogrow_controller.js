import TextareaAutogrow from 'stimulus-textarea-autogrow'

// connects to data-controller='textarea-autogrow'
export default class extends TextareaAutogrow {
  connect() {
    super.connect()
    this.element.classList.add('min-h-[4rem]')
  }
}
