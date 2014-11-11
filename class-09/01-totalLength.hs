import System.Environment
import Data.Char
import Data.List
import System.IO
{-
  Написать функцию, которая по заданному списку строк возвращает сумму длин всех строк.
-}

totalLength :: [String] -> Int
totalLength = foldl(\c x -> length x + c) 0
{-
  Написать функцию, которая по заданному символу и целому числу n строит список строк,
  содержащих 1, 2, ..., n повторений символа. Функция должна возвращать Nothing, если n=0.
-}
--дополнительные функции для построения списка строк 

fun1 :: Char -> Int -> [String]
fun1 _ 0 = []
fun1 c n =(replicate n (c) ) : (fun1  (c) (n - 1))

dop :: Char -> Int -> [String]
dop c n = reverse $fun1 (c) n

build1 :: Char -> Int -> Maybe [String]
build1 _ 0 = Nothing
build1 c  n = Just (dop (c) n)
{-
  Написать функцию, аналогичную по возможностям функции build1, но возвращающую при этом
  значение Either String [String], в котором значение слева должно свидетельствовать об
  одной из следующих особых ситуаций: 
  (*) n=0;
  (*) n > 100;
  (*) Роспотребнадзор запрещает создавать строки из символа 'x'.
-}

build2 :: Char -> Int -> Either String [String]
build2 c n 
	| n == 0 = Left "n=0"
	| n > 100 = Left "n>100"
	| c == 'x' = Left "Choose other symbol"
	| otherwise = Right  (dop c n)
	
	
{-
  Параметрами командной строки являются имя файла, символ, целое число.
  1) Пользуясь функцией totalLength и возможностями IO, как функтора, подсчитать и
     вывести общую длину строк, переданных программе в качестве аргументов командной строки.
  2) Пользуясь функцией totalLength и возможностями IO, как функтора, подсчитать и вывести общую
     длину строк, содержащихся в заданном текстовом файле (результат readFile должен быть
     предварительно преобразован к списку строк).
  3) Пользуясь функцией totalLength, подсчитать общую длину строк для значений в контекстах,
     сформированных функциями build1 и build2 (в решении следует пользоваться возможностями
     Maybe и Either String как функторов).
-}
countRows  = do
	contents <- readFile "aaa.txt"
	putStrLn $ show (totalLength $words contents)


--1)подсчет символов в словах одной строки
{-main = do
	line <- getLine
	return $totalLength $words line-}
	
	
--2Пользуясь функцией totalLength и возможностями IO, как функтора, подсчитать и вывести общую
     --длину строк, содержащихся в заданном текстовом файле (результат readFile должен быть
    -- предварительно преобразован к списку строк).
main = do
 (fileName)<-fmap head getArgs
 text<- readFile fileName
 return $totalLength $words text


