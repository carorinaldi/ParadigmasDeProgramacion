/*Armar un programa Prolog que resuelva el siguiente problema lógico:

-Quien mata es porque odia a su víctima y no es más rico que ella. Además, quien mata debe vivir en la mansión Dreadbury.
-Tía Agatha, el mayordomo y Charles son las únicas personas que viven en la mansión Dreadbury.
-Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
-Agatha odia a todos los que viven en la mansión, excepto al mayordomo.
-Quien no es odiado por el mayordomo y vive en la mansión, es más rico que tía Agatha
-El mayordomo odia a las mismas personas que odia tía Agatha.
*/
viveEnLaMansion(tiaAgatha).
viveEnLaMansion(elMayordomo).
viveEnLaMansion(charles).

odiaA(Odiado,tiaAgatha):-
    viveEnLaMansion(Odiado),
    Odiado \= tiaAgatha,
    Odiado \= elMayordomo.

odiaA(Odiado,charles):-
    viveEnLaMansion(Odiado),
    not(odiaA(Odiado,tiaAgatha)).

odiaA(Odiado,elMayordomo):-
    odiaA(Odiado,tiaAgatha).

esMasRicoQueTiaAghata(Persona):-
    viveEnLaMansion(Persona),
    not(odiaA(Persona,elMayordomo)),
    Persona \= tiaAgatha.
    

quienMata(Victima,Odiador):-
    odiaA(Victima,Odiador),
    viveEnLaMansion(Odiador),
    not(esMasRicoQueTiaAghata(Odiador)).


/*
El programa debe resolver el problema de quién mató a la tía Agatha. 
Mostrar la consulta utilizada y la respuesta obtenida.

?- quienMata(tiaAgatha,Asesino).
Asesino = charles ;
false.


Agregar los mínimos hechos y reglas necesarios para poder consultar:
- Si existe alguien que odie a milhouse.

?- odiaA(milhouse,_).       
false.

- A quién odia charles.

?- odiaA(Odiado,charles).   
Odiado = tiaAgatha ;
Odiado = elMayordomo ;
false.


- El nombre de quien odia a tía Ágatha.

?- odiaA(tiaAgatha,Odiador). 
Odiador = charles ;
false.

- Todos los odiadores y sus odiados.

?- odiaA(Odiado,Odiador).    
Odiado = charles,
Odiador = tiaAgatha ;
Odiado = tiaAgatha,
Odiador = charles ;
Odiado = elMayordomo,
Odiador = charles ;
Odiado = charles,
Odiador = elMayordomo.

- Si es cierto que el mayordomo odia a alguien.

?- odiaA(_,elMayordomo).     
true.

Mostrar las consultas utilizadas para conseguir lo anterior, junto con las respuestas obtenidas.
*/