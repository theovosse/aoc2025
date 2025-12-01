with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Exceptions;  use Ada.Exceptions;

procedure Day01a
   with SPARK_Mode => On
is
   type Dial_Position is new Integer range 0 .. 99;
   Direction : Character;
   Count : Integer;
   Format_Error : exception;
   Position : Dial_Position := 50;
   Zero_Count : Natural := 0;
begin
   while not End_Of_File loop
      Get (Direction);
      Get (Count);
      if Count < 0 then
         Put_Line ("Wrong count: " & Integer'Image (Count));
         raise Format_Error;
      end if;
      pragma Assert (Count >= 0);
      --  100 steps is a full circle
      Count := Count rem 100;
      pragma Assert (Count >= 0 and then Count < 100);
      if Direction = 'L' then
         Position :=
            Dial_Position ((Integer (Position) + 100 - Count) rem 100);
      elsif Direction = 'R' then
         Position := Dial_Position ((Integer (Position) + Count) rem 100);
      else
         Put ("Wrong direction: " & Character'Image (Direction));
         raise Format_Error;
      end if;
      if Position = 0 then
         if Zero_Count = Natural'Last then
            Put_Line ("File too long");
            raise Format_Error;
         end if;
         Zero_Count := Zero_Count + 1;
      end if;
   end loop;
   Put_Line (Integer'Image (Zero_Count));
exception
   when Format_Error =>
      Put_Line ("Format Error");
   when others =>
      Put_Line ("Input Error");
end Day01a;
