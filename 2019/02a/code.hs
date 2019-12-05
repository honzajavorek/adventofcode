import Data.List (splitAt)
import System.Environment (getArgs)

type Program = [Int]

main = do
    code:_ <- getArgs
    putStrLn . unparse . interpret 0 $ parse code

parse :: String -> Program
parse code = map readInt $ words [if c == ',' then ' ' else c | c <- code]

unparse :: Program -> String
unparse program = reverse . (drop 1) . reverse . (drop 1) $ show program

readInt :: String -> Int
readInt = read

interpret :: Int -> Program -> Program
interpret pos program
    | opcode == 99 = program
    | opcode == 1 = interpret (next pos) (op pos program (+))
    | opcode == 2 = interpret (next pos) (op pos program (*))
    | otherwise = error $ "ERROR! program: " ++ show program ++ " position: " ++ show pos
    where opcode = program !! pos

op :: Int -> Program -> (Int -> Int -> Int) -> Program
op pos program fn = apply dst (a `fn` b) program
    where a = program !! (program !! (pos + 1))
          b = program !! (program !! (pos + 2))
          dst = program !! (pos + 3)

next :: Int -> Int
next pos = pos + 4

apply :: Int -> Int -> Program -> Program
apply dst res program = prefix ++ [res] ++ suffix
    where parts = splitAt dst program
          prefix = fst parts
          suffix = tail $ snd parts
