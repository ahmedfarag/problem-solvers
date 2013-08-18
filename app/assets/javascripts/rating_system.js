/*
Author: Addam M. Driver
Date: 10/31/2006
*/

var sMax= {};	// Isthe maximum number of stars
var holder ={}; // Is the holding pattern for clicked state
var preSet ={}; // Is the PreSet value onces a selection has been made
var rated = {};

// Rollover for image Stars //
function rating(num){
	prefix = num.id.substr(0,num.id.length-1 );
	sMax[prefix] = 0;	// Isthe maximum number of stars
	for(n=0; n<num.parentNode.childNodes.length; n++){
		if(num.parentNode.childNodes[n].nodeName == "A"){
			sMax[prefix]++;	
		}
	}
	
	// if(!rated[prefix]){
		s = num.id[num.id.length-1]; // Get the selected star
		a = 0;
		
		for(i=1; i<=sMax[prefix]; i++){		
			if(i<=s){
				document.getElementById(prefix+i).className = "on";
				// document.getElementById("rateStatus").innerHTML = num.title;	
				holder[prefix] = a+1;
				a++;
			}else{
				document.getElementById(prefix+i).className = "";
			}
		}
	// }
}

// For when you roll out of the the whole thing //
function off(me){
	prefix = me.id.substr(0,me.id.length-1 );
	// if(!rated[prefix]){
		if(!preSet[prefix]){	
			for(i=1; i<=sMax[prefix]; i++){		
				document.getElementById(prefix+i).className = "";
				// document.getElementById("rateStatus").innerHTML = me.parentNode.title;
			}
		}else{
			rating(preSet[prefix]);
			// document.getElementById("rateStatus").innerHTML = document.getElementById("ratingSaved").innerHTML;
		}
	// }
}

// When you actually rate something //
function rateIt(me){
	prefix = me.id.substr(0,me.id.length-1 );
	// if(!rated[prefix]){
		// document.getElementById("rateStatus").innerHTML = document.getElementById("ratingSaved").innerHTML + " :: "+me.title;
		preSet[prefix] = me;
		// rated[prefix]=1;
		sendRate(me);
		rating(me);
	// }
}

// Send the rating information somewhere using Ajax or something like that.
function sendRate(sel){
	sol_rating = sel.id[sel.id.length - 1];
	sol = sel.id.substr(0, sel.id.length - 2);
	
	$("#solution_rating_" + sol).val(sol_rating);
	// alert("hey");
	// $("#submit_review").css('display', 'block');
	$("#solution_rating_form_" + sol).submit();
	// alert("#solution_rating_form_" + sol);
	// alert("Your rating was: "+sel.title);
}

function cancel_rating()
{
	$("#submit_review").css('display', 'none');
	// retrieve the actual previous rating
}