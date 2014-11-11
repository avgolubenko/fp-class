import System.Environment
import System.Random

{-
  Напишите функцию reduce, принимающую один целочисленный аргумент a и возвращающую 0,
  если аргумент делится на 3, a^2, если он на 3 не делится и является при этом нечётным,
  a^3 в остальных случаях.
-}

reduce :: Integral a => a -> a
reduce n
		| n `mod` 3 == 0 = 0
		| n `mod` 3 /= 0 && n `mod` 2 ==1 = (n*n)
		| otherwise = (n*n*n)

{-
  Напишите функцию, применяющую функцию reduce заданное количество раз к значению в контексте,
  являющемся функтором:
-}

reduceNF :: (Functor f, Integral a) => Int -> f a -> f a
reduceNF count f = foldl (\x _ -> fmap reduce x) f [1..count]
{-
  Реализуйте следующие функции-преобразователи произвольным, но, желательно, осмысленным и
  нетривиальным способом.
-}


toList :: Integral a => [(a, a)]  -> [a]
toList   = fmap (\(x,y)-> (reduce (x+y)))

--сумма всех хi: [(x1,_),(x2,_),...,(xn,_)]
dop :: Integral a => [(a, a)]  ->  a
dop [] = 0
dop((x,y):tail) =  x +dop(tail)

toMaybe :: Integral a => [(a, a)]  -> Maybe a
toMaybe [] = Nothing
toMaybe list = Just (dop list)

toEither :: Integral a => [(a, a)]  -> Either String a
toEither  list 
		|length list == 0 = Left "List is empty"
		|x+y== 666 = Left "First pair is 666"
		|otherwise = Right $dop  list
		where (x,y) = head list


-- воспользуйтесь в этой функции случайными числами
--toIO :: Integral a => [(a, a)]  -> IO a
--случайное значение в диапазоне первой пары
toIO list = randomRIO(x,y)
		where (x,y) = head list
		

{-
  В параметрах командной строки задано имя текстового файла, в каждой строке
  которого записана пара целых чисел, разделённых пробелами. Загрузите
  данные из файла в список пар целых чисел, преобразуйте этот список к
  значениям в контекстах [], Maybe, Either String и IO и примените к каждому
  из контекстов функцию reduceNF (значение N также должно браться из 
  параметров командной строки).
-}

parseArgs :: [String] -> (FilePath, Int)
parseArgs = undefined

readData :: FilePath -> IO [(Int, Int)]
readData = undefined

{-main = do
  (fname, n) <- parseArgs `fmap` getArgs
  ps <- readData fname
  undefined
  print $ reduceNF n (toEither ps)
  reduceNF n (toIO ps) >>= print-}

{-
  Подготовьте несколько тестовых файлов, демонстрирующих особенности различных контекстов.
  Скопируйте сюда результаты вызова программы на этих файлах.
-}
