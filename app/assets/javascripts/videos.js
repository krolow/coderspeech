$(document).ready(function () {
	$('select.sort', $('.videos.index')).change(function () {
		var path = '';

		if (this.value !== "") {
			path = '?sort=' + this.value;
		}
		window.location = $(this).data('url') + path;
	});
});