with Ada.Text_IO; use Ada.Text_IO;

package body Input with
   SPARK_Mode => On,
   Refined_State => (State => (Span, Span_Size, Span_Pos))
is

   Too_Long : exception;
   Value_Empty : exception;

   subtype Long_Natural is Integer range 0 .. Integer'Last;
   subtype Nr_Digits is Integer range 0 .. 10;
   subtype Half_Nr_Digits is Integer range 0 .. 5;
   type Span_Index is mod 2;

   Span : array (Span_Index) of Long_Natural := (0, 0);
   Span_Size : array (Span_Index) of Nr_Digits := (0, 0);
   Span_Pos : Span_Index := 0;

   procedure Add_To_Value (Ch : Character) with
      Global => (In_Out => (Span, Span_Size), Input => (Span_Pos)),
      Exceptional_Cases => (Too_Long => True)
   is
      Value : constant Long_Natural := Span (Span_Pos);
      Digit : constant Integer := Character'Pos (Ch) - 48;
   begin
      if Digit < 0 or else Digit > 9 or else
         Span_Size (Span_Pos) = Nr_Digits'Last
      then
         raise Too_Long with "value too long";
      end if;
      if Value >= (Natural'Last - Long_Natural (Digit)) / 10 then
         raise Too_Long with "value too long";
      end if;
      Span (Span_Pos) := Value * 10 + Long_Natural (Digit);
      Span_Size (Span_Pos) := Span_Size (Span_Pos) + 1;
   end Add_To_Value;

   procedure Check_Values (
      Lwb : Long_Natural; Lwb_Size : Nr_Digits;
      Upb : Long_Natural; Upb_Size : Nr_Digits
   ) is
      --  find odd powers of 10 between Lwb and Upb
      Low_Pow_10 : constant Half_Nr_Digits := Half_Nr_Digits (Integer (Lwb_Size + 1) / 2);
      High_Pow_10 : constant Half_Nr_Digits := Half_Nr_Digits (Integer (Upb_Size / 2));
      Base_10, Lowest, Highest : Natural;
   begin
      Put (Nr_Digits'Image (Low_Pow_10));
      Put ('-');
      Put (Nr_Digits'Image (High_Pow_10));
      Put (Long_Natural'Image (Lwb));
      Put ('-');
      Put (Long_Natural'Image (Upb));
      Put_Line ("");
      for Pow_10 in Low_Pow_10 .. High_Pow_10 loop
         Base_10 := 10 ** Natural (Pow_10);
         Lowest := Natural ((Long_Integer (Lwb) + Long_Integer (Base_10 + 1) - 1) / Long_Integer (Base_10 + 1));
         Highest := Natural (Long_Integer (Upb) / Long_Integer (Base_10 + 1));
         for I in Lowest .. Highest loop
            Put (Long_Integer'Image (Long_Integer (I) * Long_Integer (Base_10 + 1)));
            Put_Line ("");
         end loop;
      end loop;
   end Check_Values;

   procedure End_Span with
      Global => (
         In_Out => (Span, Span_Size, Ada.Text_IO.File_System),
         Output => (Span_Pos)),
      Exceptional_Cases => (Value_Empty => True)
   is
   begin
      Span_Pos := 0;
      if Span_Size (0) = 0 or else Span_Size (1) = 0 then
         raise Value_Empty;
      end if;
      Check_Values (Span (0), Span_Size (0), Span (1), Span_Size (1));
      Span := (0, 0);
      Span_Size := (0, 0);
   end End_Span;

   procedure Switch_Value is
   begin
      Span_Pos := 1;
   end Switch_Value;

   procedure Parse_Stdin is
      Ch : Character;
   begin
      while not End_Of_File loop
         Get (Ch);
         case Ch is
            when ',' => End_Span;
            when '-' => Switch_Value;
            when others => Add_To_Value (Ch);
         end case;
      end loop;
      End_Span;
   exception
      when others =>
         Put_Line ("Input Error");
         raise Input_Error;
   end Parse_Stdin;

end Input;