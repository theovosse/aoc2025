pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Exceptions;

with IO; use IO;
with Problem; use Problem;

procedure Day05b with
   SPARK_Mode => On
is
   Line : Unbounded_String;
   EOF : Boolean;
   Count : Big_Integer;
begin
   loop
      Read_Line (Line, EOF);
      exit when Length (Line) = 0;
      Add_Range (Line);
   end loop;
   Count := Count_Ranges;
   Put (To_String (Count));
exception
   when E : others =>
      Put_Line ("input error " & Ada.Exceptions.Exception_Information (E));
end Day05b;
