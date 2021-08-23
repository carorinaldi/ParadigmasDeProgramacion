% tripulante( Pirata , Tripulacion)
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).
tripulante(law, heart).
tripulante(bepo, heart).
tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% impactoEnRecompensa( Pirata, Evento , Monto)
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo,sabaody,500).
impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

% Punto 1

participaronDelMismo(Tripulacion1,Tripulacion2,Evento):-
    participo(Tripulacion1,Evento),
    participo(Tripulacion2,Evento),
    Tripulacion1 \= Tripulacion2.

participo(Tripulacion,Evento):-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa(Pirata, Evento, _).

/* 
Desarrollar los predicados necesarios para resolver los siguientes requerimientos:
1) Relacionar a dos tripulaciones y un evento si ambas participaron del mismo, lo cual sucede si dicho evento
impactó en la recompensa de al menos un pirata de cada tripulación. Por ejemplo:
- Debería cumplirse para las tripulaciones heart y sombreroDePaja siendo dressrosa el evento del cual
participaron ambas tripulaciones.
- No deberían haber dos tripulaciones que participen de llegadaAEastBlue, sólo los piratasDeArlong
participaron de ese evento. */

pirataDestacado(Pirata,Evento):-
    impactoEnRecompensa( Pirata, Evento , Monto),
    forall(impactoEnRecompensa(_,Evento,Monto2) , Monto >= Monto2).

pirataMasDestacadoV2(Pirata, Evento):-
    impactoEnRecompensa(Pirata, Evento, Recompensa),
    not((
      impactoEnRecompensa(_, Evento, OtraRecompensa),
      OtraRecompensa > Recompensa
    )).
  


/* 
2) Saber quién fue el pirata que más se destacó en un evento, en base al impacto que haya tenido su
recompensa.
En el caso del evento de dressrosa sería Zoro, porque su recompensa subió en $200.000.000.*/

pirataDesapercibido(Pirata,Evento):-
    tripulante(Pirata, Tripulacion),
    not(impactoEnRecompensa( Pirata, Evento , _)),
    participo(Tripulacion,Evento).
    

/*
3) Saber si un pirata pasó desapercibido en un evento, que se cumple si su recompensa no se vio impactada
por dicho evento a pesar de que su tripulación participó del mismo.
Por ejemplo esto sería cierto para Bepo para el evento dressrosa, pero no para el evento sabaody por el
cual su recompensa aumentó, ni para eniesLobby porque su tripulación no participó.
*/
recompensaTotal(Tripulacion,Sumatoria):-
    tripulante(_, Tripulacion),
    findall(Monto,recompensaXTripulacion(_,Tripulacion,Monto),Montos),
    sum_list(Montos,Sumatoria).

recompensaXTripulacion(Pirata,Tripulacion,Monto):-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa( Pirata,_, Monto).
/*
4) Saber cuál es la recompensa total de una tripulación, que es la suma de las recompensas actuales de sus
miembros.
*/
esTemible(Tripulacion):-
    forall(tripulante( Pirata , Tripulacion),esPeligroso(Pirata)).

esTemible(Tripulacion):-
    recompensaTotal(Tripulacion,Sumatoria),
    Sumatoria > 500000000.

esPeligroso(Pirata):-
    impactoEnRecompensa(Pirata,_, Monto),
    Monto > 100000000.

/*
5) Saber si una tripulación es temible. Lo es si todos sus integrantes son peligrosos o si la recompensa total
de la tripulación supera los $500.000.000. Consideramos peligrosos a piratas cuya recompensa actual
supere los $100.000.000.
*/
frutasDelDiablo(paramecia(gomugomu)).
frutasDelDiablo(paramecia(barabara)).
frutasDelDiablo(paramecia(opeope)).
frutasDelDiablo(zoan(hitohito,humano)).
frutasDelDiablo(zoan(nekoneko,leopardo)).
frutasDelDiablo(logia(mokumoku,humo)).

esPeligrosa(opeope).

esPeligrosa(Fruta):-
    frutasDelDiablo(zoan(Fruta,Especie)),
    esFeroz(Especie).

esPeligrosa(Fruta):-
    frutasDelDiablo(logia(Fruta,_)).

esFeroz(lobo).
esFeroz(leopardo).
esFeroz(anaconda).

comio(luffy,gomugomu).
comio(buggy,barabara). % de tipo paramecia, que no se considera peligrosa.
comio(law,opeope). %de tipo paramecia, que se considera peligrosa.
comio(chopper,hitohito).% de tipo zoan que lo convierte en humano.
%nami, Zoro, Ussop, Sanji, Bepo, Arlong y Hatchan no comieron frutas del diablo.
comio(lucci,nekoneko). %de tipo zoan que lo convierte en leopardo.
comio(smoker,mokumoku).% de tipo logia que le permite transformarse en humo.

esPeligroso(Pirata):-
    comio(Pirata,Fruta),
    esPeligrosa(Fruta).
/*6)
a) Necesitamos modificar la funcionalidad anterior, porque ahora hay otra forma en la cual una
persona puede considerarse peligrosa: alguien que comió una fruta peligrosa se considera
peligroso , independientemente de cuál sea el precio sobre su cabeza.
b) Justificar las decisiones de modelado tomadas para cumplir con lo pedido, tanto desde el punto
de vista de la definición como del uso de los nuevos predicados.
*/
piratasDeAsfalto(Tripulacion):-
    tripulante(_,Tripulacion),
    forall(tripulante(Pirata,Tripulacion),
    not(puedeNadar(Pirata))).

puedeNadar(Pirata):-
    tripulante(Pirata,_),
    not(comio(Pirata,_)).

/* Otra forma de resolverlo
piratasDeAsfalto(Tripulacion):-
    tripulante(_, Tripulacion),
    not((tripulante(Pirata, Tripulacion),
        puedeNadar(Pirata))). */

%7) Saber si una tripulación es de piratas de asfalto, que se cumple si ninguno de sus miembros puede nadar.*/