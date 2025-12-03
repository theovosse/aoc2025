with Ada.Text_IO; use Ada.Text_IO;

package body Input with
   SPARK_Mode => On,
   Refined_State => (State => (Span, Span_Size, Span_Pos))
is

   Too_Long : exception;
   Value_Empty : exception;
   Overflow : exception;

   subtype Long_Natural is Integer range 0 .. Integer'Last;
   subtype Nr_Digits is Integer range 0 .. 10;
   subtype Positive_Nr_Digits is Integer range 1 .. 10;
   subtype Half_Nr_Digits is Integer range 0 .. 5;
   type Span_Index is mod 2;

   Span : array (Span_Index) of Long_Natural := (0, 0);
   Span_Size : array (Span_Index) of Nr_Digits := (0, 0);
   Span_Pos : Span_Index := 0;
   Powers_Of_10 : constant array (Half_Nr_Digits) of Natural :=
      (1, 10, 100, 1000, 10000, 100000);

   function Min (A, B : Long_Natural) return Long_Natural is
      (if A < B then A else B);

   function Max (A, B : Long_Natural) return Long_Natural is
      (if A > B then A else B);

   procedure Add_To_Value (Ch : Character) with
      Global => (
         In_Out => (Span, Span_Size, Ada.Text_IO.File_System),
         Input => (Span_Pos)),
      Exceptional_Cases => (Too_Long => True)
   is
      Value : constant Long_Natural := Span (Span_Pos);
      Digit : constant Integer := Character'Pos (Ch) - 48;
   begin
      if Digit < 0 or else Digit > 9 or else
         Span_Size (Span_Pos) = Nr_Digits'Last
      then
         Put_Line ("Digit =" & Character'Image (Ch) &
                   ", Span_Size =" & Nr_Digits'Image (Span_Size (Span_Pos)));
         raise Too_Long with "value too long";
      end if;
      if Value >= (Natural'Last - Long_Natural (Digit)) / 10 then
         Put_Line ("Value =" & Long_Natural'Image (Value));
         raise Too_Long with "value too long";
      end if;
      Span (Span_Pos) := Value * 10 + Long_Natural (Digit);
      Span_Size (Span_Pos) := Span_Size (Span_Pos) + 1;
   end Add_To_Value;

   procedure Check_Values (
      Lwb : Long_Natural; Lwb_Size : Positive_Nr_Digits;
      Upb : Long_Natural; Upb_Size : Positive_Nr_Digits;
      Bad_Id_Sum : in out Long_Natural
   ) with
      Exceptional_Cases => (Overflow => True)
   is
      --  find odd powers of 10 between Lwb and Upb
      Low_Pow_10 : constant Half_Nr_Digits :=
         Half_Nr_Digits (Integer (Lwb_Size + 1) / 2);
      High_Pow_10 : constant Half_Nr_Digits :=
         Half_Nr_Digits (Integer (Upb_Size) / 2);
      Base_10, Lowest, Highest : Natural;
      Bad_Id : Long_Natural;
   begin
      Put_Line ("Range =" & Long_Natural'Image (Lwb) & "-" &
                Long_Natural'Image (Upb));
      Put_Line ("Low_Pow_10 =" & Integer'Image (Low_Pow_10) &
                ", High_Pow_10 =" & Integer'Image (High_Pow_10));
      for Pow_10 in Low_Pow_10 .. High_Pow_10 loop
         Base_10 := Powers_Of_10 (Pow_10);
         Lowest := (
            if Pow_10 = Low_Pow_10 then
               Max (
                  Natural (
                     (Long_Integer (Lwb) +
                      Long_Integer (Base_10 + 1) -
                      1) /
                    (Long_Integer (Base_10) + 1)),
                  Base_10 / 10)
            else
               Base_10 / 10);
         Highest := (
            if Pow_10 = High_Pow_10 then
               Min (
                  Natural (Long_Integer (Upb) /
                  (Long_Integer (Base_10) + 1)),
                  Base_10 - 1)
            else
               Base_10 - 1);
         Put_Line ("Pow_10 =" & Half_Nr_Digits'Image (Pow_10) &
                   ", Base_10 =" & Long_Natural'Image (Base_10) &
                   ", Lowest =" & Natural'Image (Lowest) &
                   ", Highest =" & Natural'Image (Highest));
         for I in Lowest .. Highest loop
            Bad_Id := Long_Natural (I) * Long_Natural (Base_10 + 1);
            if Bad_Id_Sum > Long_Natural'Last - Bad_Id then
               raise Overflow;
            end if;
            Bad_Id_Sum := Bad_Id_Sum + Bad_Id;
            Put_Line ("Bad_Id =" & Long_Natural'Image (Bad_Id));
         end loop;
      end loop;
      Put_Line ("");
   end Check_Values;

   procedure End_Span (Bad_Id_Sum : in out Long_Natural) with
      Global => (
         In_Out => (Span, Span_Size, Span_Pos, Ada.Text_IO.File_System)),
      Exceptional_Cases => (Value_Empty => True, Overflow => True)
   is
   begin
      if Span_Pos = 0 then
         return;
      end if;
      Span_Pos := 0;
      if Span_Size (0) = 0 or else Span_Size (1) = 0 then
         raise Value_Empty;
      end if;
      Check_Values (Span (0), Span_Size (0), Span (1), Span_Size (1),
                    Bad_Id_Sum);
      Span := (0, 0);
      Span_Size := (0, 0);
   end End_Span;

   procedure Switch_Value is
   begin
      Span_Pos := 1;
   end Switch_Value;

   procedure Parse_Stdin is
      Ch : Character;
      Bad_Id_Sum : Long_Natural := 0;
   begin
      while not End_Of_File loop
         Get (Ch);
         case Ch is
            when ',' => End_Span (Bad_Id_Sum);
            when '-' => Switch_Value;
            when others => Add_To_Value (Ch);
         end case;
      end loop;
      End_Span (Bad_Id_Sum);
      Put (Long_Natural'Image (Bad_Id_Sum));
      Put_Line ("");
   exception
      when Too_Long =>
         Put_Line ("Too long");
         raise Input_Error;
      when Value_Empty =>
         Put_Line ("Value empty");
         raise Input_Error;
      when Overflow =>
         Put_Line ("Overflow");
         raise Input_Error;
      when others =>
         Put_Line ("Unknown Exception");
         raise Input_Error;
   end Parse_Stdin;

end Input;