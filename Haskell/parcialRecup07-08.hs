import Text.Show.Functions

--Punto 1

---------- Datas y Tipos ----------

-- 1.a

data Peleador = UnPeleador {
  vida         :: Int,
  resistencia  :: Int,
  ataques      :: [Ataque]
} deriving Show

type Ataque = Peleador -> Peleador
---------- Datas y Tipos ----------

---------- Funciones Auxiliares ----------

mapVida :: (Int -> Int) -> Peleador -> Peleador
mapVida unaFuncion unPeleador = unPeleador { vida = unaFuncion . vida $ unPeleador }

reducirVida :: Int -> Peleador -> Peleador
reducirVida unaCantidad = mapVida (max 0 . subtract unaCantidad)

mapAtaques :: ([Ataque] -> [Ataque]) -> Peleador -> Peleador
mapAtaques unaFuncion unPeleador = unPeleador { ataques = unaFuncion . ataques $ unPeleador }

--1.b

estaMuerto :: Peleador -> Bool
estaMuerto  = (<1) . vida

esHabil :: Peleador -> Bool
esHabil = (>10) . length . ataques

-- 1.c

golpe :: Int -> Ataque
golpe unaIntensidad unOponente = reducirVida (unaIntensidad `div` resistencia unOponente)  unOponente

toqueDeLaMuerte :: Ataque
toqueDeLaMuerte = mapVida (const 0)

-- Patadas
{- 
patadaEn unLugar unOponente cumpleCondicion efectoSiCumple efectoSiNoCumple 
    | cumpleCondicion unOponente = efectoSiCumple
    | otherwise = efectoSiNoCumple  -}




patadaEnElPecho :: Ataque
patadaEnElPecho unOponente
    | not . estaMuerto $ unOponente = reducirVida 10 unOponente
    | otherwise = mapVida (+1) unOponente

patadaEnLaCarita :: Ataque
patadaEnLaCarita = mapVida laMitad

laMitad :: Int -> Int
laMitad = flip div 2

patadaEnLaNuca :: Ataque
patadaEnLaNuca unOponente 
    | tieneAlgunAtaque unOponente = mapAtaques (drop 1) unOponente
    | otherwise = noHacerNada unOponente

noHacerNada :: Ataque
noHacerNada = id

tieneAlgunAtaque :: Peleador -> Bool
tieneAlgunAtaque = (>0). length . ataques


--patada en cualquier otra parte no hace nada
{- 

patada: Las patadas causan distintos efectos dependiendo en qué parte del cuerpo el oponente las reciba:


Una patada en el pecho hace que un oponente vivo pierda 10 puntos de vida, pero reanima el corazón de un oponente muerto, haciéndole
 ganar 1 punto de vida.


Una patada en la carita hace que cualquier oponente pierda la mitad de la vida que le queda.


Una patada en la nuca no causa ningún daño, pero hace que el oponente olvide su primer ataque, si es que conoce alguno.


Una patada en cualquier otra parte del cuerpo no hace nada. Es necesario poder representar los otros lugares aunque no causen ningún 
efecto. (Por ejemplo, una patada en la nuca haría que un oponente que sólo sabe hacer el toque de la muerte se quede sin ataques, 
mientras que una patada a, digamos, la pantorrilla o la axila, no le haría nada).

 
 -}

-- 1.d

bruceLee :: Peleador
bruceLee = UnPeleador {
    vida = 200,
    resistencia = 25,
    ataques = [toqueDeLaMuerte , golpe 500 , foldl1 (.) (replicate 3 patadaEnLaCarita)]
}


-- Punto 2

-- 2.a

esTerrible :: Ataque -> [Peleador] -> Bool
esTerrible unAtaque unosEnemigos = esMayorALaMitadDelTotal (filter quedaVivo . map unAtaque) unosEnemigos

quedaVivo :: Peleador -> Bool
quedaVivo = not . estaMuerto

esMayorALaMitadDelTotal :: ([a1] -> [a2]) -> [a1] -> Bool
esMayorALaMitadDelTotal transformar unaLista = laMitad (length unaLista) >  length (transformar unaLista)

-- 2.b

esPeligroso :: Peleador -> [Peleador] -> Bool
esPeligroso unPeleador unosEnemigos = todosSonTerribles unPeleador (filter esHabil unosEnemigos)

todosSonTerribles :: Peleador -> [Peleador] -> Bool
todosSonTerribles unPeleador unosEnemigos  = all (flip esTerrible unosEnemigos) (ataques unPeleador)

-- 2.c

{- mejorAtaque unPeleador unEnemigo = map (ataques unPeleador) unEnemigo

atacar unPeleador unEnemigo =   -}
{- 

mejorAtaque: dados un peleador y un enemigo, el mejor ataque del peleador contra ese enemigo es el ataque del primero que deja con 
menos vida al segundo. 

invencible: un peleador es invencible para un conjunto de enemigos si, luego de recibir el mejor ataque de cada uno de ellos, sigue 
teniendo la misma vida 
que antes de ser atacado. (No importa el orden en que se apliquen los ataques). -}



carolina = UnPeleador 150 26 [golpe 300, patadaEnLaNuca]

enemigos = [carolina,bruceLee]