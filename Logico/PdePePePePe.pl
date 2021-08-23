%Base de Conocimientos

%quedaEn(Boliche, Localidad)
quedaEn(pachuli, generalLasHeras).
quedaEn(why, generalLasHeras).
quedaEn(chaplin, generalLasHeras).
quedaEn(masDe40, sanLuis).
quedaEn(qma, caba).

%entran(Boliche, CapacidadDePersonas)
entran(pachuli, 500).
entran(why, 1000).
entran(chaplin, 700).
entran(masDe40, 1200).
entran(qma, 800).

%sirveComida(Boliche)
sirveComida(chaplin).
sirveComida(qma).

%tematico(tematica)
%cachengue(listaDeCancionesHabituales)
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina)

%esDeTipo(Boliche, Tipo)
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel, buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).

% Punto 1
esPiola(Boliche):-
    sirveComida(Boliche),
    lugarPiola(Boliche).

lugarPiola(Boliche):-    
quedaEn(Boliche, generalLasHeras).

lugarPiola(Boliche):-
    entran(Boliche, CapacidadDePersonas),
    CapacidadDePersonas > 700.

% Punto 2
soloParaBailar(Boliche):-
    quedaEn(Boliche,_),
    not(sirveComida(Boliche)).

% Punto 3
podemosIrConEsa(Localidad):-
    quedaEn(_,Localidad),
    forall(quedaEn(Boliche,Localidad),esPiola(Boliche)).

% Punto 4
puntaje(Boliche,Puntaje):-
    esDeTipo(Boliche, Tipo),
    puntajePorTipo(Tipo,Puntaje).

puntajePorTipo(tematico(ochentoso),9).

puntajePorTipo(tematico(_),7):-
    not(esDeTipo(_, tematico(ochentoso))).

puntajePorTipo(electronico(_, HoraQueEmpieza, HoraQueTermina),Puntaje):-
    Puntaje is HoraQueEmpieza + HoraQueTermina.

puntajePorTipo(cachengue(ListaDeCancionesHabituales),10):-
    member(biodiesel,ListaDeCancionesHabituales),
    member(buenComportamiento,ListaDeCancionesHabituales).

% Punto 5
boliche(Boliche,Localidad,Capacidad):-
    entran(Boliche,Capacidad),
    quedaEn(Boliche,Localidad).

elMasGrande(Boliche,Localidad):-
    boliche(Boliche,Localidad,CapacidadDePersonas),
    forall(boliche(_,Localidad,OtraCapacidadDePersonas),CapacidadDePersonas>=OtraCapacidadDePersonas).

% Punto 6
puedeAbastecer(Localidad,CantidadDePersonas):-
    quedaEn(_,Localidad),
    findall(CapacidadDePersonas,boliche(_,Localidad,CapacidadDePersonas),Capacidades),
    sum_list(Capacidades,Sumatoria),
    Sumatoria >= CantidadDePersonas.

% Punto 7
esDeTipo(trabajamosYNosDivertimos, tematico(oficina)).
entran(trabajamosYNosDivertimos,500).
sirveComida(trabajamosYNosDivertimos).
quedaEn(trabajamosYNosDivertimos, concordia).

entran(elFinDelMundo,1500).
quedaEn(elFinDelMundo,ushuaia).
esDeTipo(elFinDelMundo,electronico(djLuis, 0, 6)).

entran(misterio,1000000).
sirveComida(misterio).

