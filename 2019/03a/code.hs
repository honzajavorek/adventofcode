data Direction = U | R | D | L deriving (Eq, Show)
data Segment = Segment { dir :: Direction
                       , steps :: Int
                       } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show)


main = interact $ show . minDistance . distances . crossings . (map toCoords) . (map parse) . lines


parse :: String -> [Segment]
parse code = map parseSegment $ words [if c == ',' then ' ' else c | c <- code]

parseSegment :: String -> Segment
parseSegment (char:digits) = case char of
    'U' -> Segment {dir = U, steps = steps}
    'R' -> Segment {dir = R, steps = steps}
    'D' -> Segment {dir = D, steps = steps}
    'L' -> Segment {dir = L, steps = steps}
    where steps = read digits :: Int

toCoords :: [Segment] -> [Coord]
toCoords = foldl foldSegment [Coord {x = 0, y = 0}]

foldSegment :: [Coord] -> Segment -> [Coord]
foldSegment (prevCoord:coords) (Segment { dir = dir, steps = steps })
    | dir == U = (generateCoords keep (+) steps prevCoord) ++ coords
    | dir == R = (generateCoords (+) keep steps prevCoord) ++ coords
    | dir == D = (generateCoords keep (-) steps prevCoord) ++ coords
    | dir == L = (generateCoords (-) keep steps prevCoord) ++ coords

generateCoords :: (Int -> Int -> Int) -> (Int -> Int -> Int) -> Int -> Coord -> [Coord]
generateCoords opX opY steps (Coord { x = prevX, y = prevY }) =
    map (\step -> (Coord { x = (prevX `opX` step)
                         , y = (prevY `opY` step)
                         })) [steps,(steps - 1)..0]

keep :: Int -> Int -> Int
keep coord step = coord

crossings :: [[Coord]] -> [Coord]
crossings [coords1,coords2] = [c1 | c1 <- coords1, c2 <- coords2, c1 == c2]

distances :: [Coord] -> [Int]
distances coords = [(abs x) + (abs y) | (Coord { x = x, y = y }) <- coords]

minDistance :: [Int] -> Int
minDistance distances = minimum [d | d <- distances, d > 0]
