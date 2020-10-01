import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
	static targets = ["entries", "pagination"]

	scroll() {
		const next_page = this.paginationTarget.querySelector("a[rel='next']");
		if (!next_page) {
			return;
		}

		const url = next_page.href;
		const body = document.body;
		const html = document.documentElement;

		const height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);

		if (window.pageYOffset >= height - window.innerHeight) {
			this.loadMore(url);
		}
	}

	loadMore(url) {
		Rails.ajax({
			type: 'GET',
			url: url,
			dataType: 'json',
			success: (data) => {
				this.entriesTarget.insertAdjacentHTML('beforeend', data.entries);
				this.paginationTarget.innerHTML = data.pagination;
			}
		})
	}
}
