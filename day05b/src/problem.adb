pragma Ada_2022;

with Ada.Text_IO; use Ada.Text_IO;

package body Problem with
   SPARK_Mode => On
is

   Max_Nr_Ranges : constant Integer := 200;

   subtype Range_Index is Integer range 1 .. Max_Nr_Ranges;
   subtype Nr_Ranges_Type is Integer range 0 .. Max_Nr_Ranges;

   type Value_Range is record
      Low, High : Big_Integer;
      Active : Boolean;
   end record;

   type Ranges_Type is array (Range_Index) of Value_Range;

   Nr_Ranges : Nr_Ranges_Type := 0;
   Ranges : Ranges_Type := [
      others => Value_Range'(Low => 0, High => 0, Active => True)
   ];

   procedure Find_Active_Min (
      Min : out Big_Integer;
      Found, Open, Close : out Boolean
   ) is begin
      Found := False;
      Open := False;
      Close := False;
      Min := 0;
      for I in 1 .. Nr_Ranges loop
         if Ranges (I).Active then
            if not Found then
               Min := Ranges (I).Low;
               Found := True;
               Open := True;
               Close := Close or else Ranges (I).High = Min;
            elsif Ranges (I).Low < Min then
               Min := Ranges (I).Low;
               Found := True;
               Open := True;
               Close := False;
            elsif Ranges (I).Low = Min then
               Open := True;
               Close := Close or else Ranges (I).High = Min;
            elsif Ranges (I).High < Min then
               Min := Ranges (I).High;
               Found := True;
               Open := False;
               Close := True;
            elsif Ranges (I).High = Min then
               Close := True;
            end if;
         end if;
      end loop;
   end Find_Active_Min;

   procedure Update_Min (Min : Big_Integer) is
   begin
      for I in 1 .. Nr_Ranges loop
         if Ranges (I).Active then
            if Ranges (I).High < Min then
               Ranges (I).Active := False;
            elsif Ranges (I).Low < Min then
               Ranges (I).Low := Min;
            end if;
         end if;
      end loop;
   end Update_Min;

   procedure Add_Range (Range_Line : Unbounded_String) is
      Two_Values : Split_Array;
      R : Value_Range;
      Was_Split : Boolean;
   begin
      if Nr_Ranges = Max_Nr_Ranges then
         raise Format_Error;
      end if;
      Split (Range_Line, '-', Two_Values, Was_Split);
      if not Was_Split then
         raise Format_Error;
      end if;
      Str_To_Big_Integer (Two_Values (1), R.Low);
      Str_To_Big_Integer (Two_Values (2), R.High);
      R.Active := True;
      --  Skip empty ranges
      if R.Low <= R.High then
         Nr_Ranges := Nr_Ranges + 1;
         Ranges (Nr_Ranges) := R;
      end if;
   end Add_Range;

   function Count_Ranges return Big_Integer is
      Count : Big_Integer := 0;
      Min : Big_Integer;
      Found, Open, Close : Boolean;
   begin
      loop
         Find_Active_Min (Min, Found, Open, Close);
         exit when not Found;
         Put_Line ("Min = " & To_String (Min) & ", Found = " & Boolean'Image (Found) &
                   ", Open = " & Boolean'Image (Open) & ", Close = " & Boolean'Image (Close));
         Update_Min (Min);
      end loop;
      return Count;
   end Count_Ranges;

end Problem;