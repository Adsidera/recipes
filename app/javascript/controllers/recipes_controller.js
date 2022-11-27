import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  clearSearch() {
    console.log('Im typing');
    window.history.pushState(null, null, window.location.pathname);

  };
};