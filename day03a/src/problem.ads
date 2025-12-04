with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Problem is

   Input_Error : exception;

   type Joltage is range 0 .. 99;

   function Find_Max_Joltage (Line : Unbounded_String) return Joltage;

end Problem;