========
Pa_where
========

Pa_where provides a syntax for backward declarations (allowing a
top-to-bottom declarative style), using the ``where`` keyword. Local
definitions in expressions and toplevel definitions are both supported.

See INSTALL.txt for building and installation instructions.
See LICENSE.txt for copying conditions.

Home page: https://github.com/cakeplus/pa_where


Syntax description
==================

The generic form is::

  <something> where <declaration>  ==>  <declaration> (sep) <something>

Supported forms: ``where let``, ``where val``.

Examples:

.. sourcecode:: ocaml

  expr where let a = b      ==>  let a = b in expr
  expr where let rec a = b  ==>  let rec a = b in expr
  str_item where val a = b  ==>  let a = b ;; str_item

``where let`` is the more common form, in which the ``let`` keyword is optional and can be omitted:

.. sourcecode:: ocaml

  expr where a = b  ==>  let a = b in expr

Associativity:

.. sourcecode:: ocaml

  a where b where c  ==>  (a where b) where c

Precedence:

.. sourcecode:: ocaml

  let a = b where c and d  ==>  let a = (b where c and d)


Example
=======

Input:

.. sourcecode:: ocaml

  let a =
    b c
    where b = d
    where d = e

  where val c = f

Output:

.. sourcecode:: ocaml

  let c = f

  let a =
    let d = e in
    let b = d in
  b c
