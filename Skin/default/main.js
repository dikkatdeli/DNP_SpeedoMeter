window.addEventListener('message', function(event) {

    if (event.data.action == "DisplayON"){
        skin = event.data.Skin
        $('#'+skin+'').show();
    }

    if (event.data.action == "DisplayOFF"){
        skin = event.data.Skin
        $('#'+skin+'').hide();
    }

    if (event.data.action == "setValueAF"){
	    setValueAF(event.data.value)
	}

    if (event.data.action == "setValueAS"){
	    setValueAS(event.data.value)
	}
	
	if (event.data.action == "setNumD1"){
	    setNumD1(event.data.value)
	}
	
	if (event.data.action == "setNumD2"){
	    setNumD2(event.data.value)
	}
	
	if (event.data.action == "setNumD3"){
	    setNumD3(event.data.value)
	}
	
	if (event.data.action == "setNumG"){
	    setNumG(event.data.value)
	}
	
})

function setValueAF(value){
	value = value * 1.65
	Fuel = value + 35
	$('#neadle2 .icon').css('transform', 'rotate('+Fuel+'deg)')
}

function setValueAS(value){
	value = value + 44
	$('#neadle1 .icon').css('transform', 'rotate('+value+'deg)')
}

function setNumD1(value){
	$('#digit1 img').attr('src', 'img/N'+value+'.png')
}

function setNumD2(value){
	
	$('#digit2 img').attr('src', 'img/N'+value+'.png')
}

function setNumD3(value){
	$('#digit3 img').attr('src', 'img/N'+value+'.png')
}

function setNumG(value){
	if (value == 0){
	$('#numGears img').attr('src', 'img/NR.png')
}
if (value > 0){
	$('#numGears img').attr('src', 'img/N'+value+'.png')
}
}