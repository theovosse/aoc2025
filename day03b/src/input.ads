with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Input
   with SPARK_Mode => On
is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean);

end Input;