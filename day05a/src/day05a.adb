with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with IO; use IO;
with Problem; use Problem;

procedure Day05a with
   SPARK_Mode => On
is
   Line : Unbounded_String;
   EOF : Boolean;
   Count : Natural := 0;
   In_Range : Boolean;
begin
   loop
      Read_Line (Line, EOF);
      if EOF then
         raise Format_Error;
      end if;
      exit when Length (Line) = 0;
      Add_Range (Line);
   end loop;
   while not EOF loop
      Read_Line (Line, EOF);
      if Length (Line) /= 0 then
         Check_Value (Line, In_Range);
         if In_Range then
            if Count = Natural'Last then
               raise Format_Error;
            end if;
            Count := Count + 1;
         end if;
      end if;
   end loop;
   Put_Nat (Count);
exception
   when others =>
      Put_Line ("input error");
end Day05a;
