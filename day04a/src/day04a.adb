pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Exceptions;
with IO; use IO;
with Problem; use Problem;
with Maze; use Maze;

procedure Day04a
   with SPARK_Mode => On
is
   Line : Unbounded_String;
   EOF : Boolean;
begin
   Read_Line (Line, EOF);
   if Length (Line) = 0 then
      raise Format_Error;
   end if;
   Set_Width (Length (Line));
   Add_Line (Line);
   while not EOF loop
      Read_Line (Line, EOF);
      exit when Length (Line) = 0;
      if Length (Line) /= Width then
         raise Format_Error;
      end if;
      Add_Line (Line);
   end loop;
   Put_Nat (Count_Touch);
exception
   when others =>
      Put_Line ("input error");
end Day04a;
