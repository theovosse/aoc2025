with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Input; use Input;
with Problem; use Problem;
with Ada.Exceptions;

procedure Day03a with
   SPARK_Mode => On
is
   Line : Unbounded_String;
   EOF : Boolean;
   Sum : Natural := 0;
   Max_Joltage : Joltage;
begin
   loop
      Read_Line (Line, EOF);
      exit when EOF;
      Max_Joltage := Find_Max_Joltage (Line);
      if Sum > Natural'Last - 99 then
         raise Input_Error;
      end if;
      Sum := Sum + Natural (Max_Joltage);
   end loop;
   Put_Line (Natural'Image (Sum));
exception
    when others => Put_Line ("input error");
end Day03a;
