with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Strings; use Strings;

package Problem with
   SPARK_Mode => On
is

   Format_Error : exception;

   procedure Add_Range (Range_Line : Unbounded_String) with
      Exceptional_Cases => (Format_Error => True, Conversion_Error => True);

   procedure Check_Value (
      Value_Line : Unbounded_String; In_Range : out Boolean
   ) with
      Exceptional_Cases => (Format_Error => True, Conversion_Error => True);

end Problem;