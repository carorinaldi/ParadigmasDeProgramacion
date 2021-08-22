%EscaPdeP

%persona(Apodo, Edad, Peculiaridades).
persona(ale, 15, [claustrofobia, cuentasRapidas, amorPorLosPerros]).
persona(agus, 25, [lecturaVeloz, ojoObservador, minuciosidad]).
persona(fran, 30, [fanDeLosComics]).
persona(rolo, 12, []).

%esSalaDe(NombreSala, Empresa).
esSalaDe(elPayasoExorcista, salSiPuedes).
esSalaDe(socorro, salSiPuedes).
esSalaDe(linternas, elLaberintoso).
esSalaDe(guerrasEstelares, escapepepe).
esSalaDe(fundacionDelMulo, escapepepe).

%terrorifica(CantidadDeSustos, EdadMinima).
%familiar(Tematica, CantidadDeHabitaciones).
%enigmatica(Candados).

%sala(Nombre, Experiencia).
sala(elPayasoExorcista, terrorifica(100, 18)).
sala(socorro, terrorifica(20, 12)).
sala(linternas, familiar(comics, 5)).
sala(guerrasEstelares, familiar(futurista, 7)).
sala(fundacionDelMulo, enigmatica([combinacionAlfanumerica, deLlave, deBoton])).


nivelDeDificultadDeLaSala(Sala,Dificultad):-
    sala(Sala,Experiencia),
    nivelSegunTipo(Experiencia,Dificultad).

nivelSegunTipo(terrorifica(CantidadDeSustos, EdadMinima),Dificultad):-
    Dificultad is CantidadDeSustos - EdadMinima.

nivelSegunTipo(familiar(futurista, _),15).

nivelSegunTipo(familiar(Tematica, CantidadDeHabitaciones),Dificultad):-
    Tematica \= futurista,
    Dificultad is CantidadDeHabitaciones.

nivelSegunTipo(enigmatica(Candados),Cantidad):-
    length(Candados,Cantidad).
/* 
nivelDeDificultadDeLaSala/2: para cada sala nos dice su dificultad. Para las salas de experiencia terrorífica el nivel de dificultad es la 
cantidad de sustos menos la edad mínima para ingresar. Para las de experiencia familiar es 15 si es de una temática futurista y para cualquier 
otra temática es la cantidad de habitaciones. El de las enigmáticas es la cantidad de candados que tenga. */

/* puedeSalir(Persona,Sala):-
    persona(Persona, _, _),
    not(esClaustrofobica(Persona)),
    nivelDeDificultadDeLaSala(Sala,1).
    

puedeSalir(UnaPersona,Sala):-
    nivelDeDificultadDeLaSala(Sala,Dificultad),
    Dificultad < 5,
    persona(UnaPersona, Edad, _),
    not(esClaustrofobica(UnaPersona)),
    Edad > 13. */

puedeSalir(Persona,Sala):-
    persona(Persona, _, _),
    not(esClaustrofobica(Persona)),
    condicionesParaSalir(Persona,Sala).

condicionesParaSalir(_,Sala):-
    nivelDeDificultadDeLaSala(Sala,1).
    
condicionesParaSalir(UnaPersona,Sala):-
    nivelDeDificultadDeLaSala(Sala,Dificultad),
    Dificultad < 5,
    persona(UnaPersona, Edad, _),
    Edad > 13.

esClaustrofobica(Persona):-
    persona(Persona, _, Peculiaridades),
    member(claustrofobia,Peculiaridades).

/* 
puedeSalir/2: una persona puede salir de una sala si la dificultad de la sala es 1 o si tiene más de 13 años y la dificultad es menor a 5. 
En ambos casos la persona no debe ser claustrofóbica. */

tieneSuerte(Persona,Sala):-
    puedeSalir(Persona,Sala),
    persona(Persona, _, Peculiaridades),
    length(Peculiaridades,0).

/*Otra forma sin length
sinHabilidades(Persona):-
    persona(Persona, _ , []). */

/* tieneSuerte/2: una persona tiene suerte en una sala si puede salir de ella aún sin tener ninguna peculiaridad. */

esMacabra(Empresa):-
    esSalaDe(_, Empresa),
    forall(esSalaDe(NombreSala, Empresa),sala(NombreSala, terrorifica(_, _))).
/* esMacabra/1: una empresa es macabra si todas sus salas son de experiencia terrorífica. */

empresaCopada(Empresa):-
    not(esMacabra(Empresa)),
    promedioDeDificultadDeSusSalas(Empresa,Promedio),
    Promedio < 4.

dificultadesDeUnaEmpresa(Empresa,Dificultades):-
esSalaDe(_, Empresa),
findall(Dificultad,(esSalaDe(Sala, Empresa),nivelDeDificultadDeLaSala(Sala,Dificultad)),Dificultades).


promedioDeDificultadDeSusSalas(Empresa,Promedio):-
    dificultadesDeUnaEmpresa(Empresa,Dificultades),
    sum_list(Dificultades, TotalDificultades),
    length(Dificultades, Cantidad),
    Promedio is TotalDificultades/Cantidad.

/* otra forma de resolver el promedio
promedioDificultad(Empresa, Promedio):-
    empresa(_, Empresa),
    findall(Nivel, (empresa(Sala, Empresa), nivelDeDificultadDeLaSala(Sala, Nivel)), Niveles),
    average(Niveles, Promedio).
  
  average(Lista, Promedio):-
    length(Lista, Cantidad),
    sumlist(Lista, Sumatoria),
    Promedio is Sumatoria / Cantidad. */
/* empresaCopada/1: una empresa es copada si no es macabra y el promedio de dificultad de sus salas es menor a 4. */

esSalaDe(estrellasDePelea , supercelula).
sala(estrellasDePelea,familiar(videojuegos,7)).
esSalaDe(choqueDeLaRealeza , supercelula).
%:-    sala(choqueDeLaRealeza,familiar(videojuegos,_)). no va como regla por no conocer la cantidad de salas
esSalaDe(miseriaDeLaNoche , sKPista).
sala(miseriaDeLaNoche,terrorifica(150, 21)).
%esSalaDe(_ , Vertigo). no va por no contar con salas

/* ¡Cada vez hay más salas y empresas! Conozcámoslas para agregarlas a nuestro sistema:
La empresa supercelula es dueña de salas de escape familiares ambientadas en videojuegos. La sala estrellasDePelea cuenta con 7 habitaciones 
pero lamentablemente no sabemos la cantidad que tiene su nueva sala choqueDeLaRealeza.

La empresa SKPista (fanática de un famoso escritor) es la dueña de una única sala terrorífica para mayores de 21 llamada miseriaDeLaNoche que 
nos asegura 150 sustos.

La nueva empresa que se suma a esta gran familia es Vertigo, pero aún no cuenta con salas. */
