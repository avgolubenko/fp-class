import Control.Monad.State

type Queue = [Int]
--добавление в конец
enqueue :: Int -> State Queue ()
enqueue x = do
	xs <- get
	put (xs ++ [x])
--удаление из начала	
dequeue :: State Queue Int
dequeue = do
	(x:xs) <- get
	put xs
	return x
	
queueManip :: State Queue Int
queueManip  = do
	enqueue 4
	enqueue 6
	dequeue
