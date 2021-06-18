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
abdominales :: Int -> Persona -> Persona
abdominales repeticiones unaPersona = pierdeCaloriasPorCadaRepeticion 8 repeticiones unaPersona

-- A.1.2
flexiones :: Int -> Persona -> Persona
flexiones repeticiones unaPersona = pierdeHidratacionCada10Repeticiones 2 repeticiones .pierdeCaloriasPorCadaRepeticion 16 repeticiones $unaPersona

pierdeCaloriasPorCadaRepeticion :: Int -> Int -> Persona -> Persona
pierdeCaloriasPorCadaRepeticion cantidad repeticiones = mapCantidadDeCalorias (subtract (cantidad*repeticiones))

pierdeHidratacionCada10Repeticiones :: Int ->Int-> Persona -> Persona
pierdeHidratacionCada10Repeticiones cantidad repeticiones = mapIndiceDeHidratacion (flip (-) ((div repeticiones 10) *cantidad))  

-- A.1.3
levantarPesas :: Int -> Int -> Persona -> Persona
levantarPesas repeticiones unPeso unaPersona
    | tieneAlgunaPesa unaPersona = pierdeHidratacionCada10Repeticiones unPeso repeticiones. pierdeCaloriasPorCadaRepeticion 32 repeticiones $ unaPersona
    | otherwise = id unaPersona

levantarPesas' :: Int -> Int -> Persona -> Persona
levantarPesas' repeticiones unPeso unaPersona = registrarEfectoSiCumple tieneAlgunaPesa (pierdeHidratacionCada10Repeticiones unPeso repeticiones. pierdeCaloriasPorCadaRepeticion 32 repeticiones) $ unaPersona

tieneAlgunaPesa :: Persona -> Bool
tieneAlgunaPesa = (>0).length.equipamientos 

-- A.1.4
laGranHomeroSimpson :: Persona -> Persona
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

registrarEfectoSiCumple :: (Persona -> Bool) -> (Accion) -> Accion
registrarEfectoSiCumple condicion efecto unaPersona
    | condicion unaPersona = efecto unaPersona
    | otherwise = id unaPersona

volverseBodyBuilder' :: Accion
volverseBodyBuilder' unaPersona = registrarEfectoSiCumple tieneSoloPesas (mapCantidadDeCalorias (*3). mapNombre ("BB"++)) $ unaPersona

-- A.2.4
comerUnSandwich :: Accion
comerUnSandwich unaPersona = cambiarIndiceDeHidratacion maximaHidratacion . mapCantidadDeCalorias (+500) $ unaPersona

-- Parte B

--type Rutina = Int->[Ejercicio]->Persona

ejercicios :: [Ejercicio]
ejercicios = [abdominales 2 ,flexiones 10]

noSuperaTiempoLibre :: Int -> Persona -> Bool 
noSuperaTiempoLibre tiempo unaPersona = cantidadDeTiempoDisponible unaPersona > tiempo
-- B.1
esPeligrosa :: Int -> [Ejercicio]->Persona-> Bool
esPeligrosa tiempo ejercicios unaPersona 
    | noSuperaTiempoLibre tiempo unaPersona = quedaAgotada (foldr ($) unaPersona ejercicios)


quedaAgotada :: Persona -> Bool
quedaAgotada unaPersona =  esMenorA 10 indiceDeHidratacion unaPersona && esMenorA 50 cantidadDeCalorias unaPersona

esMenorA :: Ord a1 => a1 -> (a2 -> a1) -> a2 -> Bool
esMenorA cantidad argumento = (<cantidad).argumento

-- B.2
{- esBalanceada :: Int -> [Ejercicio]->Persona-> Bool
esBalanceada tiempo ejercicios unaPersona 
    | noSuperaTiempoLibre tiempo unaPersona = esmenorA (reducirALaMitad (cantidadDeCalorias unaPersona)) $ (foldr ($) unaPersona ejercicios) && esMayorA 80 indiceDeHidratacion $ (foldr ($) unaPersona ejercicios)

esMayorA cantidad argumento = (>cantidad).argumento -}


{-

Tenemos rutinas, las cuales tienen un tiempo aproximado de duración y un listado de ejercicios. Lo primero que tenemos que tener 
en cuenta es que una persona no puede hacer rutinas cuya duración aproximada sea mayor que su tiempo libre. De cada rutina queremos
saber si:

esPeligrosa: una rutina es peligrosa cuando deja a la persona agotada. Esto sucede cuando sus calorías son menores a 50 y su índice 
de hidratación es menor a 10.

esBalanceada: una rutina es balanceada cuando al terminarla, el índice de hidratación de la persona es mayor a 80 y las calorías 
son menos de la mitad de cuando empezó. 

Modelar la rutina elAbominableAbdominal, dicha rutina dura aproximadamente 1 hora y consiste en hacer 1 abdominal, 2 abdominales, 
3 abdominales... hasta el infinito.

Parte C

Para finalizar vamos a agregar dos funcionalidades más, relacionadas a los ejercicios grupales:

seleccionarGrupoDeEjercicio: una persona quiere seleccionar quienes pueden hacer rutina con ella a partir de un grupo 
de personas. 
Las personas que pueden ser grupo de ejercicio de otra son aquellas que tengan el mismo tiempo disponible.
promedioDeRutina: dada una rutina y un grupo de personas, devolver el promedio de calorías y del índice de hidratación final del 
grupo tras haber hecho la rutina. -}
