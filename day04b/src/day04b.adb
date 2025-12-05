with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with IO; use IO;
with Problem; use Problem;
with Maze; use Maze;

procedure Day04b
   with SPARK_Mode => On
is
   Line : Unbounded_String;
   EOF : Boolean;
   Remove_Count : Natural;
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
   --  Put_Mat (Matrix); Put_Line ("");
   Flood (Remove_Count);
   --  Put_Mat (Matrix); Put_Line ("");
   Put_Nat (Remove_Count);
exception
   when others =>
      Put_Line ("input error");
end Day04b;
