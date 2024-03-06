import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  //static targets = [ "arrow", "menu", "closeButton"]
  static targets = ["content"]

    connect() {
      this.close()
    }
  
    toggle() {
      if (this.contentTarget.classList.contains("hidden")) {
        this.open()
      }
      else {
        this.close()
      }
    }
  
    open() {
      this.contentTarget.classList.remove("hidden")
    }

    close() {
      this.contentTarget.classList.add("hidden")
    }

}
