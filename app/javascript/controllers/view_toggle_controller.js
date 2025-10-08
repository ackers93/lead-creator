import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cardBtn", "tableBtn", "cardView", "tableView"]

  connect() {
    // Load saved preference or default to cards
    const savedView = localStorage.getItem('leadsView') || 'card'
    this.switchToView(savedView)
  }

  showCards() {
    this.switchToView('card')
  }

  showTable() {
    this.switchToView('table')
  }

  switchToView(view) {
    // Update button states
    this.cardBtnTarget.classList.toggle('active', view === 'card')
    this.tableBtnTarget.classList.toggle('active', view === 'table')

    // Show/hide views
    this.cardViewTarget.style.display = view === 'card' ? 'grid' : 'none'
    this.tableViewTarget.style.display = view === 'table' ? 'block' : 'none'

    // Save preference
    localStorage.setItem('leadsView', view)
  }
}
