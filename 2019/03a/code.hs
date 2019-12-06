type Distance = Int

data Direction = U | R | D | L deriving (Eq, Show)
data Instruction = Instruction { direction :: Direction
                               , steps :: Int
                               } deriving (Eq, Show)
data Coord = Coord { x :: Int
                   , y :: Int
                   } deriving (Eq, Show)


main = interact $ show . minimum . distances . crossings . (map coords) . (map parse) . lines


parse :: String -> [Instruction]
parse code = [(Instruction {direction = U, steps = 2})]

coords :: [Instruction] -> [Coord]
coords instructions = [(Coord {x = 0, y = 2})]

crossings :: [[Coord]] -> [Coord]
crossings wires = [(Coord {x = 0, y = 2})]

distances :: [Coord] -> [Distance]
distances coords = [2]
