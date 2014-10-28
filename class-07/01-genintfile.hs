{-
  Создать текстовый файл, содержащий случайные целые числа, разделённые пробелами
  и символами перевода строки. В командной строке должны задаваться следующие параметры:
  1) имя создаваемого файла;
  2) диапазон генерируемых случайных чисел: от и до;
  3) количество чисел в строке;
  4) количество строк в файле.
-}
import System.Random
import Data.List
import System.IO
import Data.Char
import System.Environment

--randInt from to =  randomRIO (from, to) 
listRandInt count from to r = take count $ randomRs (from,to) (mkStdGen r) :: [Int]

--вывод 1-го элемента
getSt count from to r = (show $head list) ++ " "
	where
		list = listRandInt count from to r

--преобразование списка в строку, элементы через пробел		
func [] = "\n"
func (x:xs) =  (show x) ++ " " ++ func (xs)

--строка содержащая случайные числа
strOfRandInt count from to r = func list
	where
		list = listRandInt count from to r
		
		
--append file [str] = appendFile file ("\n" ++ str)

genFileRand file from to count scount   = do
	if scount > 0
	then do
		rnd<-randomRIO(from,to)--случайное число - генератор для формирования спика случайных чисел
		appendFile file (strOfRandInt count from to scount)
		genFileRand file from to count rnd
	else
		return ()


--параметры командной строки : имя файла, от , до, кол-во чисел в строке, кол-во строк в файле

main = do
	(filename : from : to : count : scount : args)<- getArgs
	genFileRand filename (read from) (read to) (read count) (read scount)

