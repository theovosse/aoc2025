generic
   type T is private;

package Result is

   type Result (Success : Boolean) is
   record
      Value : T;
   end Result;

end Result;
