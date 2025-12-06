package body Strings with
    SPARK_Mode => On
is

   procedure Split (
      Str : Unbounded_String;
      Ch : Character;
      Arr : out Split_Array;
      Has_Split : out Boolean)
   is
      Tmp : Split_Array;
      Search_String : constant String (1 .. 1) := (1 => Ch);
      Search_Pos : constant Natural := Index (Str, Search_String, 1);
   begin
      if Search_Pos = 0 or else Search_Pos = Natural'Last then
         Tmp (1) := Str;
         Tmp (2) := To_Unbounded_String ("");
         Has_Split := False;
      else
         Tmp (1) := Unbounded_Slice (Str, 1, Search_Pos - 1);
         Tmp (2) := Unbounded_Slice (Str, Search_Pos + 1, Length (Str));
         Has_Split := True;
      end if;
      Arr := Tmp;
   end Split;

   procedure Str_To_Big_Integer (Str : Unbounded_String; Val : out Big_Integer)
   is
      Len : constant Integer := Length (Str);
      Res : Big_Integer := 0;
      I : Integer := 1;
      Sign : Big_Integer := 1;
      Digit : Integer;
   begin
      Val := 0;
      if Len = 0 then
         raise Conversion_Error;
      end if;
      if Element (Str, 1) = '+' then
         I := I + 1;
         pragma Assert (1 <= I);
      elsif Element (Str, 1) = '-' then
         I := I + 1;
         Sign := -1;
         pragma Assert (1 <= I);
      end if;
      pragma Assert (1 <= I);
      if I > Len then
         raise Conversion_Error with To_String (Str);
      end if;
      while I <= Len loop
         pragma Assert (1 <= I and then I <= Length (Str));
         Digit := Character'Pos (Element (Str, I)) - 48;
         if Digit < 0 or else Digit > 9 then
            raise Conversion_Error;
         end if;
         Res := Res * To_Big_Integer (10) + To_Big_Integer (Digit);
         pragma Assume (I < Integer'Last);
         I := I + 1;
         pragma Loop_Invariant (1 <= I);
      end loop;
      Val := Sign * Res;
   end Str_To_Big_Integer;

end Strings;