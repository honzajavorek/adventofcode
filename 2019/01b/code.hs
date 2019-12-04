import System.Environment (getArgs)

main = do
    args <- getArgs
    case args of
        [] -> interact $ show . calcFuels . map readFloat . lines
        mass:_ -> print . calcFuel $ readFloat mass

readFloat :: String -> Float
readFloat = read

calcFuel :: Float -> Int
calcFuel mass
    | fuel <= 0 = 0
    | otherwise = fuel + (calcFuel $ fromIntegral fuel)
    where fuel = (floor (mass / 3.0)) - 2

calcFuels :: [Float] -> Int
calcFuels = sum . map calcFuel
