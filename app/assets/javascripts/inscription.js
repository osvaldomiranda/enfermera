function extranjero(element)
{
  if (element.value=='EXTRANJERO') {
    document.getElementById('pais_origen').style.display='block'; 
  } else{
    document.getElementById('pais_origen').style.display = 'none';
  }  
}