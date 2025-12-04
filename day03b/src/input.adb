with Ada.Text_IO; use Ada.Text_IO;

package body Input
   with SPARK_Mode => Off
is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean) is
   begin
      if End_Of_File then
         EOF := True;
         return;
      end if;
      EOF := False;
      Line := To_Unbounded_String (Get_Line);
   end Read_Line;

end Input;