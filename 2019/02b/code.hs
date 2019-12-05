import Data.List (splitAt, find)
import System.Environment (getArgs)

type Address = Int
type Value = Int
type Memory = [Value]

main = do
    args <- getArgs
    case args of
        code:[] -> putStrLn . unparse . interpret 0 $ parse code
        code:resultArg:[] ->
            let result = readValue resultArg
            in putStrLn . unparse . reverseEngineer result $ parse code
        _ -> error "ERROR! bad arguments"

parse :: String -> Memory
parse code = map readValue $ words [if c == ',' then ' ' else c | c <- code]

unparse :: Memory -> String
unparse memory = reverse . (drop 1) . reverse . (drop 1) $ show memory

readValue :: String -> Value
readValue = read

reverseEngineer :: Value -> Memory -> Memory
reverseEngineer result memory =
    let values      = [99,98..0] :: [Value]
        (Just noun) = find (\n -> (resultFor memory n 0) <= result) values
        (Just verb) = find (\v -> (resultFor memory noun v) <= result) values
    in sub noun verb memory

sub :: Value -> Value -> Memory -> Memory
sub noun verb = (apply 2 verb) . (apply 1 noun)

resultFor :: Memory -> Value -> Value -> Value
resultFor memory noun verb = head $ interpret 0 memory'
    where memory' = sub noun verb memory

interpret :: Address -> Memory -> Memory
interpret ptr memory
    | opcode == 99 = memory
    | opcode == 1 = interpret (next ptr) (op ptr memory (+))
    | opcode == 2 = interpret (next ptr) (op ptr memory (*))
    | otherwise = error $ "ERROR! memory: " ++ show memory ++ " ptr: " ++ show ptr
    where opcode = memory !! ptr

op :: Address -> Memory -> (Value -> Value -> Value) -> Memory
op ptr memory fn = apply dst (a `fn` b) memory
    where a = memory !! (memory !! (ptr + 1))
          b = memory !! (memory !! (ptr + 2))
          dst = memory !! (ptr + 3)

next :: Address -> Address
next ptr = ptr + 4

apply :: Address -> Value -> Memory -> Memory
apply dstAddr res memory = prefix ++ [res] ++ suffix
    where parts = splitAt dstAddr memory
          prefix = fst parts
          suffix = tail $ snd parts
