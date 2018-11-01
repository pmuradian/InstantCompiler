-- automatically generated by BNF Converter
module Main where

import System.IO ( stdin, hGetContents, stdout, hFlush )
import System.Environment ( getArgs, getProgName )
import System.Exit ( exitFailure, exitSuccess )
import Control.Monad (when)
import System.FilePath 
import System.Process

import LexInstant
import ParInstant
import SkelJVMInstant
import PrintInstant
import AbsInstant
import ErrM

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

type Verbosity = Int

putStrV :: Verbosity -> String -> IO ()
putStrV v s = when (v > 1) $ putStrLn s

runFile :: (Print a, Show a) => Verbosity -> ParseFun a -> FilePath -> IO ()
runFile v p f = putStrLn f >> readFile f >>= run v p

printSomething :: String -> IO ()
printSomething s = putStrLn s

run :: (Print a, Show a) => Verbosity -> ParseFun a -> String -> IO ()
run v p s = let ts = myLLexer s in case p ts of
           Bad s    -> do putStrLn "\nParse              Failed...\n"
                          putStrV v "Tokens:"
                          putStrV v $ show ts
                          putStrLn s
                          exitFailure
           Ok  tree -> do putStrLn "\nParse Successful!"
                          let Ok pr = pProgram ts
                          let context = Context 0 0 0 [""]
                          let res = transProgram pr context
                          let limitStack = stackSize $ snd res
                          let limitLocals = length(names $ snd res)
                          let pre = ".class public Instant\n" ++ ".super java/lang/Object\n" ++ ".method public <init>()V \n" ++ "    aload_0 \n" ++ "    invokespecial java/lang/Object/<init>()V \n" ++ "    return \n" ++ ".end method\n"
                          let prefix = ".method public static Main()V\n.limit stack " ++ show limitStack ++ "\n.limit locals " ++ show limitLocals ++ "\n"
                          let suffix = ".end method"
                          let output = pre ++ prefix ++ fst res ++ suffix
                          writeFile "output.j" output
                          runCommand "java -jar res/jasmin.jar -d ./ output.j"
                          exitSuccess


showTree :: (Show a, Print a) => Int -> a -> IO ()
showTree v tree
 = do
      putStrV v $ "\n[Abstract Syntax]\n\n" ++ show tree
      putStrV v $ "\n[Linearized tree]\n\n" ++ printTree tree

usage :: IO ()
usage = do
  putStrLn $ unlines
    [ "usage: Call with one of the following argument combinations:"
    , "  --help          Display this help message."
    , "  (no arguments)  Parse stdin verbosely."
    , "  (files)         Parse content of files verbosely."
    , "  -s (files)      Silent mode. Parse content of files silently."
    ]
  exitFailure

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--help"] -> usage
    [] -> getContents >>= run 2 pProgram
    "-s":fs -> mapM_ (runFile 0 pProgram) fs
    fs -> mapM_ (runFile 2 pProgram) fs





