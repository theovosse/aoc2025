with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Day01b
   with SPARK_Mode => On
is

   type Dial_Position is range 0 .. 99;

   Direction : Character;
   Count : Integer;
   Format_Error : exception;
   Position : Dial_Position := 50;
   Zero_Count : Natural := 0;
   Zero_Count_Error : Boolean := False;

   procedure Count_Zero
      with Global => (In_Out => (Zero_Count, Zero_Count_Error))
   is begin
      if Zero_Count < Natural'Last then
         Zero_Count := Zero_Count + 1;
      else
         Zero_Count_Error := True;
      end if;
   end Count_Zero;

begin
   while not End_Of_File loop
      Get (Direction);
      if Direction /= 'L' and then Direction /= 'R' then
         Put_Line ("Wrong direction: " & Character'Image (Direction));
         raise Format_Error;
      end if;
      Get (Count);
      if Count < 0 then
         Put_Line ("Wrong count: " & Integer'Image (Count));
         raise Format_Error;
      end if;
      --  walk full circles
      while Count >= 100 loop
         Count_Zero;
         Count := Count - 100;
      end loop;
      pragma Assert (Count >= 0 and then Count < 100);
      if Direction = 'L' then
         if Position > 0 and then  Count >= Integer (Position) then
            Count_Zero;
         end if;
         Position := Dial_Position ((Integer (Position) + 100 - Count) rem 100);
      else
         if Count + Integer (Position) >= 100 then
            Count_Zero;
            Position := Dial_Position (Integer (Position) + Count - 100);
         else
            Position := Position + Dial_Position (Count);
         end if;
      end if;
   end loop;
   if Zero_Count_Error then
      raise Format_Error with "File too long";
   end if;
   Put_Line (Integer'Image (Zero_Count));
exception
   when Format_Error =>
      Put_Line ("Format Error");
   when others =>
      Put_Line ("Input Error");
end Day01b;
