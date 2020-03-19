import Data.List (sort)


main = interact $ show . tree . (map parse) . lines


parse :: String -> (String, String)
parse code = (l, r)
    where ([l, r]) = words [if c == ')' then ' ' else c | c <- code]
