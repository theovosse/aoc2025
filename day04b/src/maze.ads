with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Maze with
   SPARK_Mode => On
is

   Format_Error : exception;

   Max_Line_Width : constant Positive := 200;
   Max_Nr_Lines : constant Positive := 200;

   subtype Width_Type is Integer range 1 .. Max_Line_Width;
   subtype Height_Type is Integer range 0 .. Max_Nr_Lines;

   type Input_Matrix is
      array (1 .. Max_Nr_Lines, 1 .. Max_Line_Width) of Character;

   Width : Width_Type := 1;
   Height : Height_Type := 0;
   Matrix : Input_Matrix := (others => (others => ' '));

   procedure Set_Width (W : Positive) with
      Global => (Output => Width),
      Post => (Width = W),
      Exceptional_Cases => (Format_Error => W > Max_Line_Width);

   procedure Add_Line (Line : Unbounded_String) with
      Pre => (Length (Line) = Width),
      Exceptional_Cases => (Format_Error => Height = Max_Nr_Lines);

end Maze;