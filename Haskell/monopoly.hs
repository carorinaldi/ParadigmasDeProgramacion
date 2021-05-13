import Text.Show.Functions

type Accion    = Participante -> Participante
type Nombre    = String
type Precio    = Int
type Propiedad = (Nombre,Precio)

data Participante = UnParticipante {
    nombre               :: String,
    dinero               :: Int,
    tactica              :: String,
    propiedadesCompradas :: [Propiedad],
    acciones             :: [Accion]
} deriving (Show)


carolina :: Participante 
carolina = UnParticipante "Carolina" 500 "Accionista" [] [pasarPorElBanco, pagarAAccionistas]

manuel :: Participante
manuel = UnParticipante "Manuel" 500 "Oferente singular" [] [pasarPorElBanco, enojarse]

jugadorParaPrueba :: Participante
jugadorParaPrueba = UnParticipante "Merli" 500 "Oferente singular" [("Casa",10000),("Depto1",100),("Depto2",120)] [pasarPorElBanco, enojarse, subastar ("Depto1",100), pagarAAccionistas, hacerBerrinchePor ("Depto2",120)]


--ACCIONES----------------------------------------------------------------------------------------------------------------

pasarPorElBanco :: Accion
pasarPorElBanco unJugador = unJugador {dinero = dinero unJugador + 40, tactica = "Comprador Compulsivo"}

enojarse :: Accion
enojarse unJugador = unJugador {dinero = dinero unJugador + 50 , acciones = gritar : acciones unJugador}

gritar :: Accion
gritar unJugador = unJugador {nombre = "AHHHH" ++ nombre unJugador}

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador
    | (tactica unJugador == "Oferente singular") || (tactica unJugador == "Accionista") = unJugador {dinero = dinero unJugador - (snd unaPropiedad), propiedadesCompradas = unaPropiedad : (propiedadesCompradas unJugador)}

--Funciones Auxiliares para Accion cobrarAlquileres-----------------------------------------------------------------------------

esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata unaPropiedad = (<150).snd $ unaPropiedad

esPropiedadCara :: Propiedad -> Bool
esPropiedadCara  = not.esPropiedadBarata  --(>=150).snd.unaPropiedad 
---------------------------------------------------------------------------------------------------------------------------------

cobrarAlquileres :: Accion
cobrarAlquileres unJugador = unJugador {dinero = dinero unJugador + ((*10).length.filter esPropiedadBarata.propiedadesCompradas $ unJugador) + ((*20).length.filter esPropiedadCara.propiedadesCompradas $ unJugador)}

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tactica unJugador == "Accionista" = unJugador {dinero = dinero unJugador + 200}
    | otherwise = unJugador {dinero = dinero unJugador - 100}

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unaPropiedad unJugador
    | dinero unJugador >= snd unaPropiedad = unJugador {dinero = dinero unJugador - (snd unaPropiedad), propiedadesCompradas = unaPropiedad : (propiedadesCompradas unJugador)}
    | otherwise = hacerBerrinchePor unaPropiedad (gritar (unJugador {dinero = dinero unJugador + 10})) 

ultimaRonda :: Participante -> Accion
ultimaRonda unJugador = foldr1 (.) (acciones unJugador)

realizarTodasLasAcciones :: Participante -> Participante
realizarTodasLasAcciones unJugador = ultimaRonda unJugador $ unJugador

juegoFinal :: Participante -> Participante -> String
juegoFinal unJugador otroJugador 
    | (dinero.realizarTodasLasAcciones $ unJugador) > (dinero.realizarTodasLasAcciones $ otroJugador) = "El/La ganador/a es " ++ nombre unJugador
    | otherwise = "El/La ganador/a es " ++ nombre otroJugador