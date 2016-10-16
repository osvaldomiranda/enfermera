function toggleCheckbox(element,valor)
 {
    if (element.checked) {
      document.getElementById("income_monto").value = parseInt(document.getElementById("income_monto").value) + valor;
    } else {
      document.getElementById("income_monto").value = parseInt(document.getElementById("income_monto").value) - valor;
    }
 }

