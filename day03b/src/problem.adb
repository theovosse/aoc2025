package body Problem is

   type Single_Digit is range 0 .. 9;

   function Power (Base : Big_Integer; Power : Natural) return Big_Integer is
      Result : Big_Integer := 1;
   begin
      for I in 1 .. Power loop
         Result := Result * Base;
      end loop;
      return Result;
   end Power;

   function Find_Max_Joltage (
      Line : Unbounded_String;
      First_Pos, Last_Pos : Positive;
      Nr_Digits : Nr_Digits_Type;
      Pow_10 : Big_Integer) return Big_Integer
   is
      Ch_Pos : Integer;
      Digit : Single_Digit;
      Max_Digit : Single_Digit := 0;
      Max_Digit_Pos : Positive := First_Pos;
      Max_Rest : Big_Integer := 0;
   begin
      --  Find the first occurrence of the highest digit,
      --  leaving Nr_Digits - 1 accessible
      for I in First_Pos .. Last_Pos - Positive (Nr_Digits) + 1 loop
         Ch_Pos := Character'Pos (Element (Line, I));
         if Ch_Pos < 48 or else Ch_Pos > 57 then
            raise Input_Error with "digit 1";
         end if;
         Digit := Single_Digit (Ch_Pos - 48);
         if Digit > Max_Digit then
            Max_Digit := Digit;
            Max_Digit_Pos := I;
         end if;
      end loop;
      if Nr_Digits = 1 then
         return To_Big_Integer (Integer (Max_Digit));
      end if;
      Max_Rest := Find_Max_Joltage (
            Line, Max_Digit_Pos + 1, Last_Pos, Nr_Digits - 1, Pow_10 / 10);
      return To_Big_Integer (Integer (Max_Digit)) * Pow_10 + Max_Rest;
   end Find_Max_Joltage;

end Problem;