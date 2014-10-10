$(function () {
	$("input.search").keydown(function(event) {
		if (event.keycode == 13) {
			event.preventDefault();

			$(this).parent("form").submit();
		}
	});
});