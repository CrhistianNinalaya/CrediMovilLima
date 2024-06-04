function crearTabla(){
  var tabla=document.createElement('table');
  var tblbody=document.createElement('tbody');
  let formulario=document.getElementsByClassName('form-data')[2];
  // Crear un array vacío para guardar los números aleatorios
  var numeros=[];
  // Crear una variable para contar cuántos números se han generado
  var contador = 0;
  // Crear un bucle para generar los números aleatorios sin repetir
  while (contador < 10) {
    // Generar un número aleatorio entre 0 y 9
    var nrandom=Math.floor(Math.random()*10); 
    //indexof() retorna -1 si no se encuentra lo que busca
    //por ello se hace la comparacion estricta con-1
    if(numeros.indexOf(nrandom) === -1){
      // Si no está, agregarlo al array
      numeros.push(nrandom);
      // Incrementar el contador
      contador++;
    }
  }
  for(let i=0; i<3; i++){
    var hilera=document.createElement('tr');
    for(let j=0; j<3;j++){
      var celda=document.createElement('td');
      var nrcelda=document.createElement('button');      
      nrcelda.textContent=numeros[i*3+j];
      nrcelda.id="btn-digits";    
      nrcelda.onclick=function(){
        agregarDigito(numeros[i*3+j]);
      };
      celda.appendChild(nrcelda);
      hilera.appendChild(celda);  
    }
    tblbody.appendChild(hilera);
  }
  var hilera1= document.createElement('tr');
  var celda1= document.createElement('td');

  var botonend=document.createElement('button');
  botonend.textContent=numeros[9];
  botonend.onclick=function(){
    agregarDigito(numeros[9]);
  };

  botonend.id="btn-digits";
  celda1.appendChild(botonend);
  hilera1.appendChild(celda1);
  celda1.colSpan=3;
  botonend.style="width:100%";
  tblbody.appendChild(hilera1);

  tabla.appendChild(tblbody);
  
  formulario.appendChild(tabla);
}

var digitos= document.getElementById('digitos');
let cont=0;
digitos.addEventListener("click", function(){
  if(cont<1){
    crearTabla();
    cont++;
  }
});

function agregarDigito(digito){
  var input = document.getElementById('digitos');
  var valor= input.value;
  valor= valor+digito;

  input.value=valor;
}
var limitedni=8;
var limitentarjeta=10;

var inputdni=document.getElementById('nrtarjeta');
var inputntarjeta=document.getElementById('nrdoc');

//si es DNI SOLO 8 NUMEROS
//SI ES CE O PAS DEBE ADMITIR LETRAS Y DEBEN DE SER 10 CARACTERES EN TOTAL
//FALTAN VALIDACIONES
//QUE SOLO ADMITA 6 DIGITOS


