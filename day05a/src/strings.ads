with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package Strings with
    SPARK_Mode => On
is

   Conversion_Error : exception;

   type Split_Array is array (1 .. 2) of Unbounded_String;

   procedure Split (
      Str : Unbounded_String;
      Ch : Character;
      Arr : out Split_Array;
      Has_Split : out Boolean);

   procedure Str_To_Big_Integer (Str : Unbounded_String; Val : out Big_Integer)
      with Exceptional_Cases => (Conversion_Error => True);

end Strings;