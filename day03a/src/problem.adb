package body Problem
   with SPARK_Mode => On
is

   type Single_Digit is range 0 .. 9;

   procedure Find_Max1 (
      Line : Unbounded_String;
      First_Pos, Last_Pos : Positive;
      Max_Digit : out Single_Digit)
   with
      Pre => (First_Pos <= Last_Pos and then Last_Pos <= Length (Line)),
      Exceptional_Cases => (Input_Error => True)
   is
      Digit : Integer;
   begin
      Max_Digit := 0;
      for I in First_Pos .. Last_Pos loop
         Digit := Character'Pos (Element (Line, I)) - 48;
         if Digit < 0 or else Digit > 9 then
            raise Input_Error;
         end if;
         if Single_Digit (Digit) >= Max_Digit then
            Max_Digit := Single_Digit (Digit);
         end if;
      end loop;
   end Find_Max1;

   procedure Find_Max_Joltage (
      Line : Unbounded_String;
      Max_Result : out Joltage
   ) is
      Len : constant Integer := Length (Line);
      Digit1 : Integer;
      Max_Digit1 : Single_Digit := 0;
      Max_Digit2 : Single_Digit;
      Result : Joltage;
   begin
      Max_Result := 0;
      for I in 1 .. Len - 1 loop
         Digit1 := Character'Pos (Element (Line, I)) - 48;
         if Digit1 < 0 or else Digit1 > 9 then
            raise Input_Error;
         end if;
         if Single_Digit (Digit1) >= Max_Digit1 then
            Max_Digit1 := Single_Digit (Digit1);
            Find_Max1 (Line, I + 1, Len, Max_Digit2);
            Result := Joltage (Max_Digit1) * 10 + Joltage (Max_Digit2);
            if Result > Max_Result then
               Max_Result := Result;
            end if;
         end if;
      end loop;
   end Find_Max_Joltage;

end Problem;