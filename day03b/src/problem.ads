pragma Ada_2022;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package Problem is

   Input_Error : exception;

   type Nr_Digits_Type is new Integer range 1 .. 12;

   function Power (Base : Big_Integer; Power : Natural) return Big_Integer;

   function Find_Max_Joltage (
      Line : Unbounded_String;
      First_Pos, Last_Pos : Positive;
      Nr_Digits : Nr_Digits_Type;
      Pow_10 : Big_Integer) return Big_Integer
   with
      Pre => (
         Last_Pos <= Length (Line) and then
         First_Pos + Positive (Nr_Digits) - 1 <= Last_Pos
      );

end Problem;