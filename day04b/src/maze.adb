package body Maze with
   SPARK_Mode => On
is

   procedure Set_Width (W : Positive) is
   begin
      if W > Max_Line_Width then
         Width := 1;
         raise Format_Error;
      end if;
      Width := W;
   end Set_Width;

   procedure Add_Line (Line : Unbounded_String)
   is
      R : constant String := Slice (Line, 1, Width);
   begin
      if Height = Max_Nr_Lines then
         raise Format_Error;
      end if;
      Height := Height + 1;
      for J in 1 .. Width loop
         Matrix (Height, J) := R (J);
      end loop;
   end Add_Line;

end Maze;