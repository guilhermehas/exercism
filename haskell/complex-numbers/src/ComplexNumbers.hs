module ComplexNumbers
(Complex,
 conjugate,
 abs,
 exp,
 real,
 imaginary,
 mul,
 add,
 sub,
 div,
 complex) where

import Prelude hiding (div, abs, exp)
import qualified Prelude (exp)

-- Data definition -------------------------------------------------------------
data Complex a = Comp (a, a) deriving(Eq, Show)

complex :: (a, a) -> Complex a
complex n = Comp n

-- unary operators -------------------------------------------------------------
conjugate :: Num a => Complex a -> Complex a
conjugate (Comp (a,b)) = Comp (a, -b)

abs :: Floating a => Complex a -> a
abs (Comp (a,b))= sqrt $ a^2 + b^2

real :: Num a => Complex a -> a
real (Comp (a,_))= a

imaginary :: Num a => Complex a -> a
imaginary (Comp (_,b)) = b

exp :: Floating a => Complex a -> Complex a
exp (Comp (a,b)) = Comp (Prelude.exp a * cos b, Prelude.exp a * sin b)

-- binary operators ------------------------------------------------------------
mul :: Num a => Complex a -> Complex a -> Complex a
mul (Comp (a,b)) (Comp (c,d)) = Comp (a*c-b*d, a*d+b*c)

add :: Num a => Complex a -> Complex a -> Complex a
add (Comp (a,b)) (Comp (c,d)) = Comp (a+c, b+d)

sub :: Num a => Complex a -> Complex a -> Complex a
sub (Comp (a,b)) (Comp (c,d)) = Comp (a-c,b-d)

div :: Fractional a => Num a => Complex a -> Complex a -> Complex a
div x y = Comp (a/den, b/den)
    where 
        conjy = conjugate y
        den = real $ mul conjy y
        Comp (a,b) = mul x conjy
        
