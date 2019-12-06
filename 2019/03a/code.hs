type Distance = Int

data Direction = U | R | D | L deriving (Eq, Show)
data Segment = Segment { direction :: Direction
                       , steps :: Int
                       } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show)


main' = interact $ show . minimum . distances . crossings . (map coords) . (map parse) . lines
main = interact $ show . (map parse) . lines


parse :: String -> [Segment]
parse code = map parseSegment $ words [if c == ',' then ' ' else c | c <- code]

parseSegment :: String -> Segment
parseSegment (char:digits) = case char of
    'U' -> Segment {direction = U, steps = steps}
    'R' -> Segment {direction = R, steps = steps}
    'D' -> Segment {direction = D, steps = steps}
    'L' -> Segment {direction = L, steps = steps}
    where steps = read digits :: Int

coords :: [Segment] -> [Coord]
coords wireAsSegments = [(Coord {x = 0, y = 2})]

crossings :: [[Coord]] -> [Coord]
crossings wiresAsCoords = [(Coord {x = 0, y = 2})]

distances :: [Coord] -> [Distance]
distances coords = [2]
