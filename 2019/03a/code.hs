import qualified Data.Set as Set


data Segment = Segment { dir :: Char
                       , steps :: Int
                       } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show, Ord)


main = interact $ show . minDistance . distances . crossings . (map toCoords) . (map parse) . lines


parse :: String -> [Segment]
parse code = map parseSegment $ words [if c == ',' then ' ' else c | c <- code]

parseSegment :: String -> Segment
parseSegment (dir:digits) = Segment {dir = dir, steps = steps}
    where steps = read digits :: Int

toCoords :: [Segment] -> Set.Set Coord
toCoords segments = snd $ foldl foldSegment (initCoord, (Set.singleton initCoord)) segments
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
crossings [coords1,coords2] = coords1 `Set.intersection` coords2

distances :: Set.Set Coord -> [Int]
distances coords = [(abs x) + (abs y) | (Coord { x = x, y = y }) <- (Set.toList coords)]

minDistance :: [Int] -> Int
minDistance distances = minimum [d | d <- distances, d > 0]
