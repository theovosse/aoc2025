with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package IO with
   SPARK_Mode => On
is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean);

   procedure Put_Int (I : Integer);

   procedure Put_Nat (N : Natural);

end IO;