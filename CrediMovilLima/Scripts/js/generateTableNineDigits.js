// Notas: el codigo actual genera la tabla con los numeros en el segundo elemento del
// div class form-data, debe generarlo siempre en el elemento consiguiente IMPLEMENTADO

// A implementar:
// ✅ Tabla debe generarse despues del elemento seleccionado
// ✅ Usar constantes en lugar de números magicos

const NUMBERS_OF_ONE_DIGIT = 10
const ARRAY_OF_ONE_DIGITS = []

function pushArrayWithRandomNumbers(ArraytoAdd) {
  while (ArraytoAdd.length < NUMBERS_OF_ONE_DIGIT) {
    const NUMBER_RANDOM = Math.floor(Math.random() * NUMBERS_OF_ONE_DIGIT)
    if (!ArraytoAdd.includes(NUMBER_RANDOM)) {
      ArraytoAdd.push(NUMBER_RANDOM)
    }
  }
}

// Prueba de Codigo
// pushArrayWithRandomNumbers(ARRAY_OF_ONE_DIGITS)
// console.log(ARRAY_OF_ONE_DIGITS)

// Salida: [8, 9, 5, 3, 4, 0, 7, 1, 2, 6]

const MAX_ROWS = 3;
const MAX_COLUMNS = 3;

function generateTable(elementTarget) {
  let celdasCreadas = 0;

  let table = document.createElement('table')
  table.setAttribute("id", "table-six-digits")
  table.setAttribute("class", "table table-dark")

  let tbody = document.createElement('tbody')

  while (celdasCreadas < NUMBERS_OF_ONE_DIGIT) {
    let trow = document.createElement('tr')

    let celdasRestantes = NUMBERS_OF_ONE_DIGIT - celdasCreadas;
    let celdasEnEstaFila = Math.min(celdasRestantes, MAX_COLUMNS);

    for (let j = 0; j < celdasEnEstaFila; j++) {
      let tdata = document.createElement('td')
      let btn = document.createElement('button')
      btn.setAttribute('class', 'btn btn-success  w-100 ')
      btn.setAttribute('type', 'button')
            
      tdata.appendChild(btn)
      trow.appendChild(tdata)
      if (celdasRestantes < MAX_COLUMNS) {
        tdata.setAttribute('colspan', MAX_COLUMNS.toString());        
      }
      celdasCreadas++
    }
    tbody.appendChild(trow)
  }

  table.appendChild(tbody)
  elementTarget.appendChild(table)
}

function cargarTable(idTabla, array) {
  let tabla = document.getElementById(idTabla)
  let celdas = tabla.getElementsByTagName('button')
  for (let i = 0; i < celdas.length; i++) {
    celdas[i].setAttribute('id', `psw-${i}`)    
    celdas[i].textContent = array[i]
    celdas[i].setAttribute('onclick', `agregarDigito(${array[i]})`);
    delete (array[i])
  }
}

function addTable(elementAlCualAñadir) {
  pushArrayWithRandomNumbers(ARRAY_OF_ONE_DIGITS)

  generateTable(elementAlCualAñadir)
  cargarTable('table-six-digits', ARRAY_OF_ONE_DIGITS)
}

function agregarDigito(digito) {
  let input = document.getElementById('inputPassword');
  input.value+= digito
}

let input = document.getElementById('inputPassword')
let conta = 0
input.addEventListener('click', function () {
  if (conta < 1) {
    let divpassword = document.getElementById('password')
    addTable(divpassword)
    conta++
  }
})

var limitedni = 8;
var limitentarjeta = 10;

var inputdni = document.getElementById('nrtarjeta');
var inputntarjeta = document.getElementById('nrdoc');

//si es DNI SOLO 8 NUMEROS
//SI ES CE O PAS DEBE ADMITIR LETRAS Y DEBEN DE SER 10 CARACTERES EN TOTAL
//FALTAN VALIDACIONES
//QUE SOLO ADMITA 6 DIGITOS