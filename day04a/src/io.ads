with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Maze; use Maze;

package IO is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean);

   procedure Put_Int (I : Integer);

   procedure Put_Nat (N : Natural);

   procedure Write_Mat (Lines : Input_Matrix);

end IO;