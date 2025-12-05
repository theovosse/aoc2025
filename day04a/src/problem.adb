with Maze; use Maze;

package body Problem with
   SPARK_Mode => On
is

   function Count_Touch return Natural is

      function Nr_Touch (I0 : Height_Type; J0 : Width_Type) return Natural with
         Pre => (I0 >= 1)
      is
         Touch_Count : Natural := 0;
      begin
         for I in (if I0 = 1 then 1 else I0 - 1) ..
                  (if I0 >= Height then Height else I0 + 1)
         loop
            pragma Assert (1 <= I and then I <= Height);
            for J in (if J0 = 1 then 1 else J0 - 1) ..
                     (if J0 >= Width then Width else J0 + 1)
            loop
               pragma Assert (1 <= J and then J <= Width);
               if (I /= I0 or else J /= J0) and then Matrix (I, J) = '@' then
                  pragma Assume (Touch_Count <= 8);
                  Touch_Count := Touch_Count + 1;
               end if;
            end loop;
         end loop;
         return Touch_Count;
      end Nr_Touch;

      Maze_Count : Natural;
      Row_Count : Natural;

   begin
      Maze_Count := 0;
      for I in 1 .. Height loop
         pragma Loop_Invariant (Maze_Count < I * Width);
         Row_Count := 0;
         for J in 1 .. Width loop
            pragma Assert (Row_Count < J);
            if Matrix (I, J) = '@' and then Nr_Touch (I, J) < 4 then
               Row_Count := Row_Count + 1;
            end if;
            pragma Loop_Invariant (Row_Count <= J);
         end loop;
         Maze_Count := Maze_Count + Row_Count;
      end loop;
      return Maze_Count;
   end Count_Touch;

end Problem;