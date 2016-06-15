$(".high-intensity").hover(function(){
    $('.high-hide').delay(250).toggle(500, "swing");
},function(){
    $('.high-hide').delay(250).toggle(500, "swing");
});

$(".med-intensity").hover(function(){
    $('.med-hide').delay(250).toggle(500, "swing");
},function(){
    $('.med-hide').delay(250).toggle(500, "swing");
});

$(".low-intensity").hover(function(){
    $('.low-hide').delay(250).toggle(500, "swing");
},function(){
    $('.low-hide').delay(250).toggle(500, "swing");
});

$(".rest-intensity").hover(function(){
    $('.rest-hide').delay(250).toggle(500, "swing");
},function(){
    $('.rest-hide').delay(250).toggle(500, "swing");
});


$(document).ready(function() {
    $('.dash-box').removeClass('fade-out');
});

$(document).ready(function() {
    $('.inner').removeClass('fade-out');
});

$(document).ready(function() {
    $('.play-box').removeClass('fade-out');
});