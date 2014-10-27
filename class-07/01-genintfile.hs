{-
  Создать текстовый файл, содержащий случайные целые числа, разделённые пробелами
  и символами перевода строки. В командной строке должны задаваться следующие параметры:
  1) имя создаваемого файла;
  2) диапазон генерируемых случайных чисел: от и до;
  3) количество чисел в строке;
  4) количество строк в файле.
-}
import System.Random
import Control.Monad(when)


{-gen randNum len = do
	gen <- getStdGen
	return $ take len $ randomRs ('a','z') gen-}
	
--генерация списка случайных чисел заданной длины и заданного диапазона
--listRandInt::Int->Int->Int->[Int]
randInt from to =  randomRIO (from, to) 


--listRandInt = randoms (mkStdGen 11) 
--создание строки с заданным количеством случайных чисел, разделенных пробелом
--strOfRandInt::count->[Int]->String
strOfRandInt count from to = show randomRIO(from, to) ++" "
--l1::a->a->a->IO[a]->[a]
--l1 count from to = print ($listRandInt count from to)
