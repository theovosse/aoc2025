pragma Ada_2022;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package Problem with
   SPARK_Mode => On
is

   Input_Error : exception;

   type Nr_Digits_Type is new Integer range 1 .. 12;

   function Power (Base : Big_Integer; Power : Natural) return Big_Integer;

   procedure Find_Max_Joltage (
      Line : Unbounded_String;
      First_Pos, Last_Pos : Positive;
      Nr_Digits : Nr_Digits_Type;
      Pow_10 : Big_Integer;
      Max_Joltage : out Big_Integer)
   with
      Pre => (
         Last_Pos <= Length (Line) and then
         Long_Integer (First_Pos) + Long_Integer (Nr_Digits) - 1 <= Long_Integer (Last_Pos)
      ),
      Exceptional_Cases => (Input_Error => True);

end Problem;