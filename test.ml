(** In-expression where *)

(* let _ = b where c = d *)
let _ = b where c = d

(* let _ = *)
(*   b where c = d *)
(*     where e = f *)
let _ =
  b where c = d
    where e = f

(* let _ = b where let c = d *)
let _ = b where c = d

(* let _ = *)
(*   b where let c = d *)
(*     where e = f *)
let _ =
  b where let c = d
    where e = f

(* let a = b where rec b = c *)
(* let a = b where let rec b = c *)
let a = b where rec b = c
let a = b where let rec b = c


(* let _ =  *)
(*   b where (c = d where e = f) *)
let _ = 
  b where c = (d where e = f)


(* let a = b *)
(*       where c = d *)
(*       and e = f *)
let a = b
      where c = d
      and e = f

(* let _ = *)
(*   b where c = d *)
(*       and e = f *)
(*     where g = h *)
let _ =
  b where c = d
      and e = f
    where g = h

(** Toplevel where *)

(* let a = b *)
(* where val c = d *)
let a = b
where val c = d

(* let a = b *)
(* where val c = d *)
(*       and e = f *)
(* where val g = h *)
let a = b
where val c = d
      and e = f
where val g = h

(* type a = b *)
(* where val c = d *)
type a = b
where val c = d

(** Mixing *)

(* let a = b *)
(* and c = d *)
(*       where e = f *)
let a = b
and c = d
      where e = f

(* let a = b *)
(*       where c = d *)
(* where val e = f *)
let a = b
      where c = d
where val e = f

