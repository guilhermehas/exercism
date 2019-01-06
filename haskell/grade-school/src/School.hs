module School (School, add, empty, grade, sorted) where

import Data.List

data School = Grades [[String]]

listFromSchool :: School -> [[String]]
listFromSchool (Grades grades) = grades

replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x:xs)
    | n == 0 = newVal:xs
    | otherwise = x:replaceNth (n-1) newVal xs

add :: Int -> String -> School -> School
add gradeNum student school = Grades $ replaceNth gradeNum sortedPeople listSchool
    where 
        listSchool = listFromSchool school
        peopleWithThatGrade = listFromSchool school !! gradeNum
        sortedPeople = sort $ student : peopleWithThatGrade

empty :: School
empty = Grades [[] | _ <- [0..4]]

grade :: Int -> School -> [String]
grade gradeNum school = listFromSchool school !! gradeNum

sorted :: School -> [(Int, [String])]
sorted school = [(x,y) | x <- [0..], y <- listFromSchool school]
