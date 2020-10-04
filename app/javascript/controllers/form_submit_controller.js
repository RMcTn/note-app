import { Controller } from "stimulus";

export default class extends Controller {
	static targets = ["button"]

	keyPress(event) {
		if (event.ctrlKey && event.code === "Enter") {
			this.submit();
		}
	}

	submit() {
		this.buttonTarget.click();
	}
}
