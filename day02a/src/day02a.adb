with Ada.Text_IO; use Ada.Text_IO;
with Input; use Input;

procedure Day02a with
   SPARK_Mode => On,
   Global => (In_Out => (Ada.Text_IO.File_System, Input.State))
is

begin
   Parse_Stdin;
exception
    when others =>
        Put_Line ("Input Error");
end Day02a;
