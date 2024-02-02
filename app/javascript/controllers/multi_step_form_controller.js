import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multi-step-form"
export default class extends Controller {
  static targets = ['step', 'action', 'progress']

  connect() {
    this.stepTargets.slice(1).map((step) => step.classList.add('hidden'))
  }

  next(event) { this.move(event) }

  previous(event) { this.move(event) }

  move(event) {
    const steps = this.stepTargets
    const progress = this.progressTarget
    this.toggle_steps(event, steps)
    this.toggle_progress(progress, steps)
  }

  toggle_steps(event, steps) {
    event.preventDefault()
    const to_step = event.target.dataset.to

    const [to_show, to_hide] = steps.reduce((acc, val) => val.dataset.step === to_step ? [[...acc[0], val], acc[1]] : [acc[0], [...acc[1], val]], [[], []])

    to_hide.map((step) => step.classList.add('hidden'))
    to_show.map((step) => step.classList.remove('hidden'))
  }

  toggle_progress(progress, steps) {
    const steps_size = steps.length
    const active_step = parseInt(
      steps.find((e) => !e.classList.contains('hidden')).dataset.step
    ) + 1
    const to_remove = Array.from(progress.classList).find((e => e.startsWith('w-')))

    progress.classList.remove(to_remove)
    if (active_step === steps_size) {
      console.log(1)
      progress.classList.add(`w-full`)
    } else {
      console.log(2)
      progress.classList.add(`w-${active_step}/${steps_size}`)
    }
  }
}
