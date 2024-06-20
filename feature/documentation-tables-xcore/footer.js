document.addEventListener('DOMContentLoaded', function() {
	const headers = ['h2', 'h3', 'h4', 'h5', 'h6'];
	for (let i = 0; i < headers.length; i++) {
		const headerElements = document.getElementsByTagName(headers[i]);
		for (let j = 0; j < headerElements.length; j++) {
			const header = headerElements[j];
			header.innerHTML += '<a class="header-link" href="#' + header.parentNode.id + '"><span class="link-icon"></span></a>';
		}
	}
});
