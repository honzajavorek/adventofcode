import Data.List (splitAt)
import System.Environment (getArgs)

type Address = Int
type Value = Int
type Memory = [Value]

main = do
    code:_ <- getArgs
    putStrLn . unparse . interpret 0 $ parse code

parse :: String -> Memory
parse code = map readValue $ words [if c == ',' then ' ' else c | c <- code]

unparse :: Memory -> String
unparse memory = reverse . (drop 1) . reverse . (drop 1) $ show memory

readValue :: String -> Value
readValue = read

interpret :: Address -> Memory -> Memory
interpret ptr memory
    | opcode == 99 = memory
    | opcode == 1 = interpret (next ptr) (op ptr memory (+))
    | opcode == 2 = interpret (next ptr) (op ptr memory (*))
    | otherwise = error $ "ERROR! memory: " ++ show memory ++ " ptr: " ++ show ptr
    where opcode = memory !! ptr

op :: Address -> Memory -> (Value -> Value -> Value) -> Memory
op ptr memory fn = apply dst (a `fn` b) memory
    where paramA = memory !! (ptr + 1)
          a = memory !! paramA
          paramB = memory !! (ptr + 2)
          b = memory !! paramB
          dst = memory !! (ptr + 3)

next :: Address -> Address
next ptr = ptr + 4

apply :: Address -> Value -> Memory -> Memory
apply dstAddr res memory = prefix ++ [res] ++ suffix
    where parts = splitAt dstAddr memory
          prefix = fst parts
          suffix = tail $ snd parts
