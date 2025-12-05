pragma Ada_2022;

with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

package body Problem with
   SPARK_Mode => On
is

   Max_Nr_Ranges : constant Integer := 200;

   subtype Range_Index is Integer range 1 .. Max_Nr_Ranges;
   subtype Nr_Ranges_Type is Integer range 0 .. Max_Nr_Ranges;

   type Value_Range is record
      Low, High : Big_Integer;
   end record;

   type Ranges_Type is array (Range_Index) of Value_Range;

   Nr_Ranges : Nr_Ranges_Type := 0;
   Ranges : Ranges_Type := [others => Value_Range'(Low => 0, High => 0)];

   procedure Add_Range (Range_Line : Unbounded_String) is
      Two_Values : Split_Array;
      R : Value_Range;
      Was_Split : Boolean;
   begin
      if Nr_Ranges = Max_Nr_Ranges then
         raise Format_Error;
      end if;
      Split (Range_Line, '-', Two_Values, Was_Split);
      if not Was_Split then
         raise Format_Error;
      end if;
      Str_To_Big_Integer (Two_Values (1), R.Low);
      Str_To_Big_Integer (Two_Values (2), R.High);
      Nr_Ranges := Nr_Ranges + 1;
      Ranges (Nr_Ranges) := R;
   end Add_Range;

   procedure Check_Value (
      Value_Line : Unbounded_String; In_Range : out Boolean
   ) is
      Value : Big_Integer;
   begin
      Str_To_Big_Integer (Value_Line, Value);
      In_Range := (for some I in 1 .. Nr_Ranges =>
         Ranges (I).Low <= Value and then Value <= Ranges (I).High);
   end Check_Value;

end Problem;