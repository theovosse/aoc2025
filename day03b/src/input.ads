with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Input is

   procedure Read_Line (
      Line : out Unbounded_String;
      EOF : out Boolean);

end Input;