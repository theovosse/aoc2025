pragma Ada_2022;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Strings; use Strings;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package Problem with
   SPARK_Mode => On
is

   Format_Error : exception;

   procedure Add_Range (Range_Line : Unbounded_String) with
      Exceptional_Cases => (Format_Error => True, Conversion_Error => True);

   function Count_Ranges return Big_Integer;

end Problem;