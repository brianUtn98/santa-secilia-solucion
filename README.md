# santa-secilia-solucion

## Errores comunes:

### Confusión general de algunos operadores. Dejo acá la aclaración:

* Cuando queremos decir que algo es igual a otra cosa, la solución no debería ser usar ni = ni is, ya que siempre en esas ocasiones podemos unificar.
* Si necesitamos asignar el resultado de una operación a una variable, se usa is.
* Comparar por igual no sería necesario por lo que dije en el primer bullet, sin embargo se haría con == (no con =). Es decir = es para asignar y == es para comaprar. El operador = no se utiliza nunca, ya que no resuelve las operaciones.

Un ejemplo de esto sería lo siguiente:

```prolog
banda(Banda,_,Localidad,_),festival(Festival,OtraLocalidad),Localidad == OtraLocalidad
```
Esto estaría **mal**, ya que directamente se puede hacer así:
```prolog
banda(Banda,_,Localidad,_),festival(Festival,Localidad)
```
Estos errores pesan bastante, ya que al comerterlos nosotros inferimos en que no entendieron parte del paradigma.

### Punto 1 - festival

En este punto se tomó como opciones válidas ambas alternativas:

Alternativa 1:
```prolog
%festival(Festival,Localidad).

%bandaConfirmada(Banda,Festival).
```
Alternativa 2:
```prolog
%festival(Festival,Localidad,Bandas).
```

La primer alternativa es más interesante, ya que nos ahorra el trabajo con listas y nos podemos concetrar en las relaciones, sin utilizar member en algunos lugares.

### Punto 2 - esExitosa/1

* Utilizar generadores de más, agregando banda/4 para generar la banda cuando con genero/2 ya se está generando.
```prolog
esExitosa(Banda):-banda(Banda,_,_,_),genero(Banda,Genero),...
```
* Utilizar múltiples veces el predicado genero/2 en lugar de usarlo una sola vez y abstraer la condición del mismo y utilizar pattern matching.
```prolog
esExitosa(Banda):-banda(Banda,_,_,_),generoExitoso(Banda).
generoExitoso(Banda):-genero(Banda,rock(mixto,_)).
generoExitoso(Banda):-genero(Banda,rock(glam,80)).
...
```
* Utilizar == en lugar de pattern matching.
```prolog
generoExitoso(rock(glam,Anio)):-Anio == 80.
```

### Punto 3 - seraEterna/1

* Utilizar generador de más con banda/4 cuando con esExitosa/1 ya alcanzaba.

* Utilizar 2 veces esExitosa así:

```prolog
seraEterna(Banda):- ...,esExitosa(Banda).
seraEterna(Banda):- ...,esExitosa(Banda).
```
Este error pesaba bastante, ya que tenían una clara opción de abstraer lógica y repetirla no estaba bien.
La opción correcta era tener un solo predicado seraEterna/1 y delegar lo de la cantidad de integrantes o el año en predicados auxiliares así:
```prolog
seraEterna(Banda):-esExitosa(Banda),cumpleEterna(Banda).
%Un caso que se fije si los integrantes son 4.
cumpleEterna(Banda):-... 
%Un caso que se fije si se formó entre el 60 y el 80.
cumpleEterna(Banda):-...
```
* Fijarse que la cantidad de integrantes sea 4 usando ==
```prolog
...,length(Integrantes,Cantidad),Cantidad == 4.
```
Este error también pesaba, ya que no estaban aprovechando la unificación:
```prolog
...,length(Integrantes,4).
```
* Utilizar >= y <= en lugar de between para verificar el año de formación.
No pesaba tanto, pero es algo a mencionar.

### Punto 4 - leConvieneParticipar/2

* A esta altura, el error es similar al cometido en otros puntos: Fijarse que la localidad de formación de la banda sea igual a la localidad en la que se hace el festival con ==
```prolog
leConvieneParticipar(Banda,Festival):-banda(Banda,_,Localidad,_),festival(Festival,OtraLocalidad),noParticipa(Banda,Festival), Localidad == OtraLocalidad.
```
Acá lo correcto era:
```prolog
leConvieneParticipar(Banda,Festival):-banda(Banda,_,Localidad,_),festival(Festival,Localidad),noParticipa(Banda,Festival).
```
Otra vez aprovechando la unificación.

### Punto 5 - seGraba/1

En general este punto, quienes lo lograron hacer, lo hicieron bien. Algunas personas quisieron utilizar findall en lugar de forall, lo que era erroneo.

### Punto 6 - anioHistorico/1

Acá el error más común fue contar la cantidad de veces que aparece el Año en la base de conocimientos en lugar de fijarse cuantas bandas se formaron, además de que el Año ya estaría unificado fuera del findall.
```prolog
anioHistorico(Anio):-banda(_,Anio,_,_),findall(Anio,banda(_,Anio,_,_),ListaDeAnios),...
```
Lo que queremos contar es la cantidad de bandas formadas para ese Año, algo así:
```prolog
anioHistorico(Anio):-banda(_,Anio,_,_),findall(Banda,seFormoEn(Banda,Anio),Bandas),...
```

### Conclusión

En general el recuperatorio tomado era sencillo (dentro de todo lo que se podía tomar). Se esperaba que exploten algunos conceptos para hacer todos los puntos lo mejor posible.
Se evaluaba 
* Unificación
* Pattern-matching
* Relaciones
* Abstracción
* Functores
* Inversibilidad
* findall
* forall

Recuerden que no es la solución correcta la que funciona, sino la que aprovecha los conceptos centrales del paradigma.


