type Distance = Int

data Direction = U | R | D | L deriving (Eq, Show)
data Segment = Segment { dir :: Direction
                       , steps :: Int
                       } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show)


main' = interact $ show . minimum . distances . crossings . (map toCoords) . (map parse) . lines
main = interact $ show . (map toCoords) . (map parse) . lines


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
foldSegment (lastCoord@(Coord { x = x, y = y }):coords) (Segment { dir = dir, steps = steps })
    | otherwise = lastCoord:coords

crossings :: [[Coord]] -> [Coord]
crossings coords = [(Coord {x = 0, y = 2})]

distances :: [Coord] -> [Distance]
distances coords = [2]
