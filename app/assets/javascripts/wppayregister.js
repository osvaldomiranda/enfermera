function toggleCheckbox(element,valor)
 {
    if (element.checked) {
      document.getElementById("income_monto").value = parseInt(document.getElementById("income_monto").value) + valor;
    } else {
      document.getElementById("income_monto").value = parseInt(document.getElementById("income_monto").value) - valor;
    }
 }

function toggleAllCheckbox(divid, element, valor)
{
  var checkboxes = new Array(); 
  var checkboxes = document.querySelectorAll('#' + divid + ' input[type="checkbox"]');

  for (var i=0; i<checkboxes.length; i++)  {
    if (checkboxes[i].type == 'checkbox')   {
      if (element.checked){
        checkboxes[i].checked = true;
        document.getElementById("income_monto").value = (checkboxes.length-1) * valor;
      } else {
        checkboxes[i].checked = false;
        document.getElementById("income_monto").value = 0;
      }
    }
  }
}



