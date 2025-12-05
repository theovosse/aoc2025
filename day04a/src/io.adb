with Ada.Text_IO; use Ada.Text_IO;

package body IO is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean) is
   begin
      if End_Of_File then
         Line := To_Unbounded_String ("");
         EOF := True;
         return;
      end if;
      EOF := False;
      Line := To_Unbounded_String (Get_Line);
   end Read_Line;

   procedure Put_Int (I : Integer) is
   begin
      Ada.Text_IO.Put (Integer'Image (I));
   end Put_Int;

   procedure Put_Nat (N : Natural) is
      Img : constant String := Natural'Image (N);
   begin
      Ada.Text_IO.Put (Img (2 .. Img'Length));
   end Put_Nat;

   procedure Write_Mat (Lines : Input_Matrix) is
   begin
      for I in 1 .. Height loop
         for J in 1 .. Width loop
            Put (Lines (I, J));
         end loop;
         Put_Line ("");
      end loop;
   end Write_Mat;

end IO;