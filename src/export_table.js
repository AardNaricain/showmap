var body = document.getElementsByTagName("body")[0];
var script = document.createElement('script');
script.type = "text/javascript";
script.src = "https://code.jquery.com/jquery-3.6.0.min.js";
body.appendChild(script);

maplinks_by_area = {}
found_row = null;
$('tr').each(function(i, row) {
	$row = $(row)
	var arid = $row.find('td.column-3').html()
	if (arid) {
		anchors = [];
		$row.find('a').each(function(i, anchor) {
			anchors.push(`<a href=\"${anchor.href}\" target=\"_blank\" rel=\"noopener noreferrer\">${anchor.textContent}</a>`)
		});
		maplinks_by_area[arid] = {
			"details": $row.find('td.column-1').html().replace('<br>', ''),
			"maps": anchors.join('<br>'),
		};
	}
});
JSON.stringify(maplinks_by_area);
