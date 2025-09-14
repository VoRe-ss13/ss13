function updateSearch() {
<<<<<<< HEAD
	var filter_text = document.getElementById('filter');
	var filter = filter_text.value.toLowerCase();

	var vars_ol = document.getElementById('vars');
	var lis = vars_ol.children;
	// the above line can be changed to vars_ol.getElementsByTagName("li") to filter child lists too
	// potential todo: implement a per-admin toggle for this

	for(var i = 0; i < lis.length; i++) {
		var li = lis[i];
		if(filter == "" || li.innerText.toLowerCase().indexOf(filter) != -1) {
			li.style.display = "block";
		} else {
			li.style.display = "none";
		}
	}
}

function selectTextField() {
	var filter_text = document.getElementById('filter');
	filter_text.focus();
	filter_text.select();
}

function loadPage(list) {
	if(list.options[list.selectedIndex].value == "") {
		return;
	}
=======
  const filter_text = document.getElementById('filter');
  const filter = filter_text.value.toLowerCase();

  const vars_ol = document.getElementById('vars');
  const lis = vars_ol.children;
  // the above line can be changed to vars_ol.getElementsByTagName("li") to filter child lists too
  // potential todo: implement a per-admin toggle for this

  for (let i = 0; i < lis.length; i++) {
    const li = lis[i];
    if (filter === '' || li.innerText.toLowerCase().indexOf(filter) !== -1) {
      li.style.display = 'block';
    } else {
      li.style.display = 'none';
    }
  }
}

function selectTextField() {
  const filter_text = document.getElementById('filter');
  filter_text.focus();
  filter_text.select();
}

function loadPage(list) {
  if (list.options[list.selectedIndex].value === '') {
    return;
  }
>>>>>>> 5a62077f2c ([MIRROR] JSON Logging Refactor (#11623))

	location.href=list.options[list.selectedIndex].value;
	list.selectedIndex = 0;
}
