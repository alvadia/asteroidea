{-|
Module      : Core
Description : Module that contains all calculations
Copyright   : Just Nothing
Stability   : in progress
-}
module Core(calcOne, calcFlame)  where
import System.Random
import Types
import RND (fromVec)
import Data.List      (map, concatMap, replicate, zipWith, iterate, sum, zip, (!!), filter, take, drop, length)
import Prelude hiding (map, concatMap, replicate, zipWith, iterate, sum, zip, (!!), filter, take, drop, length)

-- | Если xaos в трансформе - пустой список, то будем считать что переходы к любой другой трансформе равновозможны
initXaos :: Model -> Model
initXaos m@(Model {mTransforms = trs}) = m { mTransforms = map ini trs }
 where
  ini tr | tXaos tr == [] = tr { tXaos =  replicate (length trs) 1 }
         | otherwise      = tr

-- | xaos и веса не меняются в процессе вычисления => все необходимые "модифицированные" веса можно вычислить заранее
prepareModel :: Model -> Model
prepareModel m@(Model {mTransforms = trs}) = m { mTransforms = preparedTransforms }
 where 
  preparedTransforms = map prepare trs
  prepare tr = tr { tXaos = zipWith (*) (tXaos tr) $ map tWeight trs}  

-- | Calculate whole fractal
calcFlame :: StdGen ->  Model -> [(Vec,Double,Int)]
calcFlame gen model = finalestPoints
  where    
    pointList = take outerIter (randBUSlist gen) -- лист с точками что будем обсчитывать
    outerIter = mOuterIter model -- внешний цикл
    preparedModel = prepareModel $ initXaos model
    points = concatMap (calcPath preparedModel) pointList
    finalFunc (Just final) = map (calcOne final)
    finalFunc Nothing      = id
    finalestPoints =
      filter inBounds $
        map
        (  \ (GVec _ vec, c,i) -> ((applyCamera model vec), c, i) )
        (finalFunc (mFinal model) points)
    inBounds ((x,y),_,_) = (control x) && (control y)
    control x = (x > - 1) && (x < 1)

-- | Calculate and plot Path of one point
calcPath ::  Model->Vec->[CastGen]
calcPath  model vec = path
  where
    gen =  fromVec vec
    innerIter = mInnerIter model --  внутренний цикл
    start = (GVec gen vec, 0.5, 0) -- here can be INITIAL transform
    infPath = iterate (\ c@(_,_,i) -> calcOne (mTransforms model !! i) c) start -- весь путь точки
    path = drop 20 $ take innerIter $ infPath 

-- | Calculate one point and color
calcOne :: Transform -> CastGen -> CastGen
calcOne transform ( gv, col, ptr) = (newGVec, newCol, newPtr)
  where
    (newPtr , newGen) = getTransformNumber transform (ptr, (gvGen gv))
    newGVec =  tVariation transform $ gv {gvGen = newGen}
    speed = tColorSpeed transform
    newCol = (
               (1 + speed)*col
              +
               (1 - speed)*(tColorPosition transform)
             ) /2  
{-# INLINE calcOne #-}

applyCamera :: Model -> Vec -> Vec
applyCamera m (x,y) = (x',y')
  where
    (shiftX, shiftY) = (x+ mShiftX m, y+ mShiftY m)
    rotRad = (pi/180*) $ mRotation m
    sinT = sin rotRad
    cosT = cos rotRad
    scale = mScale m
    (rotX, rotY) = ( shiftX*cosT-shiftY*sinT, shiftY*cosT+shiftX*sinT)
    (x',y') =(rotX * scale,rotY * scale)

-- | Список случайных точек из би-единичного квадрата:
randBUSlist :: RandomGen g => g -> [Vec]
randBUSlist gen = zip randXS randYS
  where
    (g1,g2) = split gen
    randXS = randomRs (-1,1) g1
    randYS = randomRs (-1,1) g2

getTransformNumber :: RandomGen g => Transform -> (Int, g) -> (Int, g)
getTransformNumber transform (ptr, gen) 
  | tXaos transform == [] = (ptr, gen)
  | otherwise = (chooseTransform list pointer, gen') 
   where
    (rand, gen') = randomR (0, 1) gen
    list = tXaos transform
    pointer = rand * sum list
{-# INLINE getTransformNumber #-}

chooseTransform :: [Double] -> Double -> Int
chooseTransform [] _ = 0
chooseTransform ( w : ws ) num
  | (num <= w) = 0
  | otherwise = 1 + chooseTransform ws (num - w)