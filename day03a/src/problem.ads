with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Problem
   with SPARK_Mode => On
is

   Input_Error : exception;

   type Joltage is range 0 .. 99;

   procedure Find_Max_Joltage (
      Line : Unbounded_String;
      Max_Result : out Joltage
   ) with
      Exceptional_Cases => (Input_Error => True);

end Problem;