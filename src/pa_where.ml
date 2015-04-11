
(* Pa_where, backward declaration syntax for OCaml
   -----------------------------------------------------------------------------
   Copyright (C) 2007, mfp <mfp@acm.org>
                 2007, bluestorm <bluestorm.dylc@gmail.com>

   License:
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Library General Public
     License version 2.1, as published by the Free Software Foundation.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

     See the GNU Library General Public License version 2.1 for more details
     (enclosed in LICENSE.txt).

   Description:
     The following extension introduces a syntax for backward declarations
     (allowing a top-to-bottom declarative style), using the "where" keyword.

     See README.rst file for more information.
*)


open Camlp4
open Sig

module Id = struct
  let name = "pa_where"
  let version = "0.4"
  let description = "'where' backward declarations"
end

module Make (Syntax: Sig.Camlp4Syntax) = struct
  include Syntax

  let test_where_let = Gram.Entry.of_parser "test_where_let"
    (fun strm ->
       match Stream.npeek 2 strm with
         [ (KEYWORD "where", _); (KEYWORD ("let" | "rec"), _) ] -> ()
       | [ (KEYWORD "where", _); (KEYWORD _, _) ] -> raise Stream.Failure
       | [ (KEYWORD "where", _); _ ] -> ()
       | _ -> raise Stream.Failure)

  EXTEND Gram
    GLOBAL: expr str_item;

    str_item: BEFORE "top"
      [ NONA
          [ e = str_item; "where"; "val"; rf = opt_rec; lb = where_binding ->
              <:str_item< value $rec:rf$ $lb$ ; $e$ >>
          ] ];

    expr: BEFORE "top"
      [ NONA
          [ e = expr; test_where_let; "where"; OPT "let";
            rf = opt_rec; lb = where_binding ->
              <:expr< let $rec:rf$ $lb$ in $e$ >>
          ] ];

    where_binding:
      [ LEFTA
          [ b1 = SELF; "and"; b2 = SELF -> <:binding< $b1$ and $b2$ >>
            | p = ipatt; e = fun_binding' -> <:binding< $p$ = $e$ >> ] ];

    fun_binding':
      [ RIGHTA
          [ p = labeled_ipatt; e = SELF ->
              <:expr< fun $p$ -> $e$ >>
              | "="; e = expr LEVEL "top" -> <:expr< $e$ >>
              | ":"; t = ctyp; "="; e = expr LEVEL "top" -> <:expr< ($e$ : $t$) >>
              | ":>"; t = ctyp; "="; e = expr LEVEL "top" -> <:expr< ($e$ :> $t$) >> ] ];
    END
end

let module M = Register.OCamlSyntaxExtension(Id)(Make) in ()
