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

------MAPPERS--------------------------------------------------------------------------------------------------------------------------
mapDinero :: (Int->Int) -> Participante -> Participante
mapDinero unaFuncion unParticipante = unParticipante {dinero = unaFuncion.dinero $ unParticipante}

mapNombre :: (String->String) -> Participante -> Participante
mapNombre unaFuncion unParticipante = unParticipante {nombre = unaFuncion.nombre $ unParticipante}

cambiarTactica :: String -> Participante -> Participante
cambiarTactica tacticaNueva unParticipante = unParticipante {tactica = tacticaNueva}

agregarAccion :: Accion -> Participante -> Participante
agregarAccion accion unPersonaje = unPersonaje {acciones = accion : acciones unPersonaje}

agregarPropiedad ::Propiedad-> Participante -> Participante
agregarPropiedad propiedad unPersonaje = unPersonaje {propiedadesCompradas = propiedad : propiedadesCompradas unPersonaje}

--ACCIONES----------------------------------------------------------------------------------------------------------------
pasarPorElBanco :: Accion
pasarPorElBanco unJugador = cambiarTactica "Comprador Compulsivo".mapDinero (+40) $ unJugador

enojarse :: Accion
enojarse unJugador = agregarAccion gritar. mapDinero (+50) $ unJugador

gritar :: Accion
gritar unJugador = mapNombre ("AHHHH" ++) unJugador

--Funciones Auxiliares para subastar----------------------------------------------------------------------------------------------
tieneTactica :: String -> Participante -> Bool
tieneTactica unaTactica = (==unaTactica).tactica 

ganaLaPropiedad :: Propiedad -> Accion
ganaLaPropiedad unaPropiedad unJugador = agregarPropiedad unaPropiedad.mapDinero (subtract (snd unaPropiedad)) $ unJugador
-----------------------------------------------------------------------------------------------------------------------------------

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador
    | tieneTactica "OferenteSingular" unJugador || tieneTactica "Accionista" unJugador = ganaLaPropiedad unaPropiedad unJugador
    | otherwise = unJugador

--Funciones Auxiliares para Accion cobrarAlquileres-----------------------------------------------------------------------------
esPropiedadBarata :: Propiedad -> Bool
esPropiedadBarata unaPropiedad = (<150).snd $ unaPropiedad

esPropiedadCara :: Propiedad -> Bool
esPropiedadCara  = not.esPropiedadBarata  --(>=150).snd.unaPropiedad 

cantidadPropiedadesSegun :: (Propiedad->Bool) -> Int -> Participante-> Int
cantidadPropiedadesSegun condicion valorAMultiplicar = (*valorAMultiplicar).length.filter condicion.propiedadesCompradas 

calcularAlquileres :: Participante -> Int
calcularAlquileres unJugador =  (cantidadPropiedadesSegun esPropiedadBarata 10 unJugador) + (cantidadPropiedadesSegun esPropiedadCara 20 unJugador)
---------------------------------------------------------------------------------------------------------------------------------

cobrarAlquileres :: Accion
cobrarAlquileres unJugador = mapDinero (+ calcularAlquileres unJugador) unJugador

pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tieneTactica "Accionista" unJugador = mapDinero (+200) unJugador
    | otherwise = mapDinero ((-)100) unJugador

hacerBerrinchePor :: Propiedad -> Accion
hacerBerrinchePor unaPropiedad unJugador
    | dinero unJugador >= snd unaPropiedad = ganaLaPropiedad unaPropiedad unJugador
    | otherwise = hacerBerrinchePor unaPropiedad (gritar.mapDinero (+10) $ unJugador) 

ultimaRonda :: Participante -> Accion
ultimaRonda unJugador = foldr1 (.) (acciones unJugador)

dineroUltimaRonda :: Participante -> Int
dineroUltimaRonda unJugador = dinero.ultimaRonda unJugador $ unJugador

juegoFinal :: Participante -> Participante -> Participante
juegoFinal unJugador otroJugador 
    | (dineroUltimaRonda unJugador) > (dineroUltimaRonda otroJugador) = ultimaRonda unJugador $ unJugador
    | otherwise = ultimaRonda otroJugador $ otroJugador