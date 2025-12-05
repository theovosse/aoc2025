with Maze; use Maze;

package body Problem with
   SPARK_Mode => On
is

   procedure Flood (Count : out Natural) is

      function Nr_Touch (I0 : Height_Type; J0 : Width_Type) return Natural with
         Pre => (I0 >= 1)
      is
         Touch_Count : Natural := 0;
      begin
         for I in (if I0 = 1 then 1 else I0 - 1) ..
                  (if I0 >= Height then Height else I0 + 1)
         loop
            for J in (if J0 = 1 then 1 else J0 - 1) ..
                     (if J0 >= Width then Width else J0 + 1)
            loop
               if (I /= I0 or else J /= J0) and then Matrix (I, J) = '@' then
                  pragma Assume (Touch_Count < 8);
                  Touch_Count := Touch_Count + 1;
               end if;
            end loop;
         end loop;
         return Touch_Count;
      end Nr_Touch;

      procedure Propagate (I0 : Height_Type; J0 : Width_Type) with
         Pre => (I0 >= 1)
      is begin
         if Matrix (I0, J0) /= '@' or else Nr_Touch (I0, J0) >= 4 then
            return;
         end if;
         Matrix (I0, J0) := '.';
         pragma Assume (Count <= Height * Width);
         Count := Count + 1;
         for I in (if I0 = 1 then 1 else I0 - 1) ..
                  (if I0 >= Height then Height else I0 + 1) loop
            for J in (if J0 = 1 then 1 else J0 - 1) ..
                     (if J0 >= Width then Width else J0 + 1) loop
               if I /= I0 or else J /= J0 then
                  Propagate (I, J);
               end if;
            end loop;
         end loop;
      end Propagate;

   begin
      Count := 0;
      for I in 1 .. Height loop
         for J in 1 .. Width loop
            Propagate (I, J);
         end loop;
      end loop;
   end Flood;

end Problem;