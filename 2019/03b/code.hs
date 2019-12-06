import qualified Data.Set as Set


data Segment = Segment { dir :: Char
                       , steps :: Int
                       } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show, Ord)
type Wire = [Segment]


main = interact processInput


processInput :: String -> String
processInput input = show tracked
    where wires = map parse $ lines input
          coords = map toCoords wires
          crossingCoords = crossings coords
          tracked = trackCrossings wires crossingCoords

parse :: String -> Wire
parse code = map parseSegment $ words [if c == ',' then ' ' else c | c <- code]

parseSegment :: String -> Segment
parseSegment (dir:digits) = Segment {dir = dir, steps = steps}
    where steps = read digits :: Int

toCoords :: Wire -> Set.Set Coord
toCoords wires = snd $ foldl foldSegment (initCoord, (Set.singleton initCoord)) wires
    where initCoord = Coord {x = 0, y = 0}

foldSegment :: (Coord, Set.Set Coord) -> Segment -> (Coord, Set.Set Coord)
foldSegment (prevCoord, coords) (Segment { dir = dir, steps = steps }) = (lastNewCoord, mergedCoords)
    where
        (newCoords@(lastNewCoord:_)) = case dir of
            'U' -> generateCoords keep (+) steps prevCoord
            'R' -> generateCoords (+) keep steps prevCoord
            'D' -> generateCoords keep (-) steps prevCoord
            'L' -> generateCoords (-) keep steps prevCoord
        mergedCoords = coords `Set.union` (Set.fromList newCoords)

generateCoords :: (Int -> Int -> Int) -> (Int -> Int -> Int) -> Int -> Coord -> [Coord]
generateCoords opX opY steps (Coord { x = prevX, y = prevY }) =
    map (\step -> (Coord { x = (prevX `opX` step)
                         , y = (prevY `opY` step)
                         })) [steps,(steps - 1)..0]

keep :: Int -> Int -> Int
keep coord step = coord

crossings :: [Set.Set Coord] -> Set.Set Coord
crossings [coords1, coords2] = coords1 `Set.intersection` coords2


-- from this line below, the code gets ugly, I didn't have time to make it nice or anything

trackCrossings :: [Wire] -> Set.Set Coord -> Int
trackCrossings [wire1, wire2] crossingCoords = result
    where crossingCoordsList = [c | c <- Set.toList crossingCoords, c /= (Coord {x = 0, y = 0})]
          wire1steps = map (countSteps wire1) crossingCoordsList
          wire2steps = map (countSteps wire2) crossingCoordsList
          combos = zip wire1steps wire2steps
          result = minimum [w1 + w2 | (w1, w2) <- combos]

countSteps :: Wire -> Coord -> Int
countSteps wire coord = (length $ takeWhile (/= coord) coordsList)
    where foldResult = foldl foldSegment' (Coord {x = 0, y = 0}, []) wire
          coordsList = reverse $ snd foldResult

foldSegment' :: (Coord, [Coord]) -> Segment -> (Coord, [Coord])
foldSegment' (prevCoord, coords) (Segment { dir = dir, steps = steps }) = (lastNewCoord, mergedCoords)
    where
        (newCoords@(lastNewCoord:_)) = case dir of
            'U' -> generateCoords keep (+) steps prevCoord
            'R' -> generateCoords (+) keep steps prevCoord
            'D' -> generateCoords keep (-) steps prevCoord
            'L' -> generateCoords (-) keep steps prevCoord
        mergedCoords = newCoords ++ (if coords == [] then [] else tail coords)
