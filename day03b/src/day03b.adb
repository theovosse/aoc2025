pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;
with Input; use Input;
with Problem; use Problem;

procedure Day03b with
   SPARK_Mode => On
is

   Line : Unbounded_String;
   EOF : Boolean;
   Sum : Big_Integer := 0;
   Max_Joltage : Big_Integer;
begin
   loop
      Read_Line (Line, EOF);
      exit when EOF;
      if Length (Line) < 12 then
         raise Input_Error with "Short Line";
      end if;
      pragma assert (Integer (Nr_Digits_Type'Last) <= Length (Line));
      Find_Max_Joltage (
         Line, 1, Length (Line), Nr_Digits_Type'Last,
         Power (10, Natural (Nr_Digits_Type'Last - 1)),
         Max_Joltage);
      Sum := Sum + Max_Joltage;
   end loop;
   Put_Line (To_String (Sum));
exception
   when others => Put_Line ("input error");
end Day03b;
