package Input with
   SPARK_Mode => On,
   Abstract_State => State,
   Initializes => State
is

   Input_Error : exception;

   procedure Parse_Stdin
   with
      Exceptional_Cases => (Input_Error => True);

end Input;