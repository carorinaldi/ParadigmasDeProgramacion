import Text.Show.Functions
import Data.Char (toUpper, isUpper)
import Data.List (nub)

type Equipamiento   = String

-- Parte A  

data Persona = UnaPersona {
    nombre                     :: String,
    cantidadDeCalorias         :: Int,
    indiceDeHidratacion        :: Int, -- Va de 0-100
    cantidadDeTiempoDisponible :: Int,
    equipamientos              :: [Equipamiento]   
} deriving (Show)

-- Personas
carolina :: Persona
carolina = UnaPersona "Carolina"   1500 80 4 ["pesa","bandas elasticas"]

javier :: Persona
javier   = UnaPersona "Javier"   1800 70 5 ["pesa","pesa","pesa"]

-- helpers
mapNombre :: (String->String) -> Persona -> Persona
mapNombre unaFuncion unPersona = unPersona {nombre = unaFuncion.nombre $ unPersona}

mapCantidadDeCalorias :: (Int->Int) -> Persona -> Persona
mapCantidadDeCalorias unaFuncion unPersona = unPersona {cantidadDeCalorias = unaFuncion.cantidadDeCalorias $ unPersona}

mapIndiceDeHidratacion :: (Int->Int) -> Persona -> Persona
mapIndiceDeHidratacion unaFuncion unPersona = unPersona {indiceDeHidratacion = unaFuncion.indiceDeHidratacion $ unPersona}

mapEquipamientos :: ([Equipamiento]->[Equipamiento]) -> Persona -> Persona
mapEquipamientos unaFuncion unPersona = unPersona {equipamientos = unaFuncion.equipamientos $ unPersona}

cambiarIndiceDeHidratacion :: Int -> Persona -> Persona
cambiarIndiceDeHidratacion nuevoIndice unaPersona = unaPersona {indiceDeHidratacion = nuevoIndice }
-- helpers

-- A.1.1
type Ejercicio = Persona -> Persona
abdominales :: Int -> Ejercicio
abdominales repeticiones unaPersona = pierdeCaloriasPorCadaRepeticion 8 repeticiones unaPersona

-- A.1.2
flexiones :: Int -> Ejercicio
flexiones repeticiones unaPersona = pierdeHidratacionCada10Repeticiones 2 repeticiones .pierdeCaloriasPorCadaRepeticion 16 repeticiones $unaPersona

pierdeCaloriasPorCadaRepeticion :: Int -> Int -> Persona -> Persona
pierdeCaloriasPorCadaRepeticion cantidad repeticiones = mapCantidadDeCalorias (subtract (cantidad*repeticiones))

pierdeHidratacionCada10Repeticiones :: Int ->Int-> Persona -> Persona
pierdeHidratacionCada10Repeticiones cantidad repeticiones = mapIndiceDeHidratacion (flip (-) ((div repeticiones 10) *cantidad))  

-- A.1.3
levantarPesas :: Int -> Int -> Ejercicio
levantarPesas repeticiones unPeso unaPersona
    | tieneAlgunaPesa unaPersona = pierdeHidratacionCada10Repeticiones unPeso repeticiones. pierdeCaloriasPorCadaRepeticion 32 repeticiones $ unaPersona
    | otherwise = id unaPersona

levantarPesas' :: Int -> Int -> Ejercicio
levantarPesas' repeticiones unPeso unaPersona = registrarEfectoSiCumple tieneAlgunaPesa (pierdeHidratacionCada10Repeticiones unPeso repeticiones. pierdeCaloriasPorCadaRepeticion 32 repeticiones) $ unaPersona

tieneAlgunaPesa :: Persona -> Bool
tieneAlgunaPesa = (>0).length.equipamientos 

-- A.1.4
laGranHomeroSimpson :: Ejercicio
laGranHomeroSimpson = id

-- A.2.1
type Accion = Persona -> Persona

renovarEquipo :: Accion
renovarEquipo unaPersona= mapEquipamientos (map ("Nuevo " ++)) $ unaPersona

-- A.2.2
volverseYoguista :: Accion
volverseYoguista unaPersona = cambiarIndiceDeHidratacion (min ((indiceDeHidratacion unaPersona)*2) maximaHidratacion). mapCantidadDeCalorias reducirALaMitad $ unaPersona

maximaHidratacion :: Int
maximaHidratacion = 100

reducirALaMitad :: Int -> Int
reducirALaMitad = flip div 2

-- A.2.3
volverseBodyBuilder :: Accion
volverseBodyBuilder unaPersona
    | tieneSoloPesas unaPersona = mapCantidadDeCalorias (*3). mapNombre ("BB"++) $ unaPersona
    | otherwise = unaPersona

tieneSoloPesas :: Persona -> Bool
tieneSoloPesas = all esPesa.equipamientos

esPesa :: String -> Bool
esPesa = (=="pesa")

registrarEfectoSiCumple :: (Persona -> Bool) -> (Persona->Persona) -> Persona -> Persona
registrarEfectoSiCumple condicion efecto unaPersona
    | condicion unaPersona = efecto unaPersona
    | otherwise = id unaPersona

volverseBodyBuilder' :: Accion
volverseBodyBuilder' unaPersona = registrarEfectoSiCumple tieneSoloPesas (mapCantidadDeCalorias (*3). mapNombre ("BB"++)) $ unaPersona

-- A.2.4
comerUnSandwich :: Accion
comerUnSandwich unaPersona = cambiarIndiceDeHidratacion maximaHidratacion . mapCantidadDeCalorias (+500) $ unaPersona

-- Parte B
type Tiempo = Int
type Rutina = (Tiempo,[Ejercicio])

tiempo :: Rutina -> Tiempo
tiempo (tiempo, _) = tiempo

ejercicios :: Rutina -> [Ejercicio]
ejercicios (_, ejercicios) = ejercicios

ejerciciosVarios :: [Ejercicio]
ejerciciosVarios = [abdominales 2 ,flexiones 10, levantarPesas' 2 3]

rutina1 :: Rutina
rutina1 = (2,ejerciciosVarios)

noSuperaTiempoLibre :: Rutina -> Persona -> Bool 
noSuperaTiempoLibre unaRutina unaPersona = cantidadDeTiempoDisponible unaPersona > tiempo unaRutina

realizarRutina :: Rutina -> Persona -> Persona
realizarRutina unaRutina unaPersona 
    | noSuperaTiempoLibre unaRutina unaPersona = foldr ($) unaPersona (ejercicios unaRutina) 
    | otherwise = unaPersona

-- B.1
esPeligrosa :: Rutina -> Persona -> Bool
esPeligrosa unaRutina unaPersona = quedaAgotada.realizarRutina unaRutina $unaPersona

quedaAgotada :: Persona -> Bool
quedaAgotada unaPersona =  esMenorA 10 indiceDeHidratacion unaPersona && esMenorA 50 cantidadDeCalorias unaPersona

esMenorA :: Ord a1 => a1 -> (a2 -> a1) -> a2 -> Bool
esMenorA cantidad argumento = (<cantidad).argumento

-- B.2
esBalanceada :: Rutina -> Persona -> Bool
esBalanceada unaRutina unaPersona = (reducirALaMitad (cantidadDeCalorias unaPersona)) > (cantidadDeCalorias(realizarRutina unaRutina unaPersona)) && (esMayorA 80 indiceDeHidratacion $ (realizarRutina unaRutina unaPersona))

esMayorA :: Ord a1 => a1 -> (a2 -> a1) -> a2 -> Bool
esMayorA cantidad argumento = (>cantidad).argumento

elAbominableAbdominal :: Rutina
elAbominableAbdominal = (1,map abdominales [1..])

-- Parte C
-- C.1
seleccionarGrupoDeEjercicio :: Persona -> [Persona] -> [Persona]
seleccionarGrupoDeEjercicio unaPersona unGrupo = filter (puedeSerGrupo unaPersona) unGrupo

puedeSerGrupo :: Persona -> Persona -> Bool
puedeSerGrupo unaPersona otraPersona = cantidadDeTiempoDisponible unaPersona == cantidadDeTiempoDisponible otraPersona 

-- C.2
promedioDeRutina :: Rutina -> [Persona] -> (Int, Int)
promedioDeRutina unaRutina unGrupo = (promedio.map cantidadDeCalorias.map (realizarRutina unaRutina) $unGrupo , promedio.map indiceDeHidratacion.map (realizarRutina unaRutina) $unGrupo)

promedio :: Foldable t => t Int -> Int
promedio lista = div (sum lista) (length lista)
