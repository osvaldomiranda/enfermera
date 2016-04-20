
var inter,t;
function interval(){
    t=1;
    inter=setInterval(function(){
        callpi(" ");
    },1000,"JavaScript");
}
function timeout(){
    clear();
    setTimeout(function(){
         callpi("");
    },2000,"JavaScript");
}
function clear(){
    clearInterval(inter);
}

function callpi(url) {
$.ajax({
    method: "get",
    url: "/sensomatica/calltemp",
    data: " "
  })
    .done(function( url ) {
      window.location = "/sensomatica/calltemp";
    })
    .fail( function(xhr, textStatus, errorThrown) {
       alert(errorThrown);
     });

}

