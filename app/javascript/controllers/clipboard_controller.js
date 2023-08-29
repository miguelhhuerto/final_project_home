import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]

  copy() {
    const linkContent = this.linkTarget.textContent;
    navigator.clipboard.writeText(linkContent);
    const notice = document.querySelector(".notice");
    if (notice) {
      notice.innerText = "Copied: " + linkContent;
    }
  }
}
This code should work with your existing setup and provide the functionality you're looking for. The "Copy to Clipboard" button, when clicked, will copy the link to the clipboard and display a notice indicating the successful copy. Make sure to replace "http://client.com:3000" with the appropriate base URL of your application.





