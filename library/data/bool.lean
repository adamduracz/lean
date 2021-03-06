/-
Copyright (c) 2014 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Module: data.bool
Author: Leonardo de Moura
-/

import logic.eq
open eq eq.ops decidable

namespace bool
  local attribute bor [reducible]
  local attribute band [reducible]

  theorem dichotomy (b : bool) : b = ff ∨ b = tt :=
  bool.cases_on b (or.inl rfl) (or.inr rfl)

  theorem cond_ff {A : Type} (t e : A) : cond ff t e = e :=
  rfl

  theorem cond_tt {A : Type} (t e : A) : cond tt t e = t :=
  rfl

  theorem ff_ne_tt : ¬ ff = tt :=
  assume H : ff = tt, absurd
    (calc true  = cond tt true false : cond_tt
            ... = cond ff true false : H
            ... = false              : cond_ff)
    true_ne_false

  theorem eq_tt_of_ne_ff : ∀ {a : bool}, a ≠ ff → a = tt
  | @eq_tt_of_ne_ff tt H := rfl
  | @eq_tt_of_ne_ff ff H := absurd rfl H

  theorem eq_ff_of_ne_tt : ∀ {a : bool}, a ≠ tt → a = ff
  | @eq_ff_of_ne_tt tt H := absurd rfl H
  | @eq_ff_of_ne_tt ff H := rfl

  theorem absurd_of_eq_ff_of_eq_tt {B : Prop} {a : bool} (H₁ : a = ff) (H₂ : a = tt) : B :=
  absurd (H₁⁻¹ ⬝ H₂) ff_ne_tt

  theorem tt_bor (a : bool) : bor tt a = tt :=
  rfl

  notation a || b := bor a b

  theorem bor_tt (a : bool) : a || tt = tt :=
  bool.cases_on a rfl rfl

  theorem ff_bor (a : bool) : ff || a = a :=
  bool.cases_on a rfl rfl

  theorem bor_ff (a : bool) : a || ff = a :=
  bool.cases_on a rfl rfl

  theorem bor_self (a : bool) : a || a = a :=
  bool.cases_on a rfl rfl

  theorem bor.comm (a b : bool) : a || b = b || a :=
  bool.cases_on a
    (bool.cases_on b rfl rfl)
    (bool.cases_on b rfl rfl)

  theorem bor.assoc (a b c : bool) : (a || b) || c = a || (b || c) :=
  match a with
  | ff := by rewrite *ff_bor
  | tt := by rewrite *tt_bor
  end

  theorem or_of_bor_eq {a b : bool} : a || b = tt → a = tt ∨ b = tt :=
  bool.rec_on a
    (assume H : ff || b = tt,
      have Hb : b = tt, from !ff_bor ▸ H,
      or.inr Hb)
    (assume H, or.inl rfl)

  theorem ff_band (a : bool) : ff && a = ff :=
  rfl

  theorem tt_band (a : bool) : tt && a = a :=
  bool.cases_on a rfl rfl

  theorem band_ff (a : bool) : a && ff = ff :=
  bool.cases_on a rfl rfl

  theorem band_tt (a : bool) : a && tt = a :=
  bool.cases_on a rfl rfl

  theorem band_self (a : bool) : a && a = a :=
  bool.cases_on a rfl rfl

  theorem band.comm (a b : bool) : a && b = b && a :=
  bool.cases_on a
    (bool.cases_on b rfl rfl)
    (bool.cases_on b rfl rfl)

  theorem band.assoc (a b c : bool) : (a && b) && c = a && (b && c) :=
  match a with
  | ff := by rewrite *ff_band
  | tt := by rewrite *tt_band
  end

  theorem band_elim_left {a b : bool} (H : a && b = tt) : a = tt :=
  or.elim (dichotomy a)
    (assume H0 : a = ff,
      absurd
        (calc ff = ff && b : ff_band
             ... = a && b  : H0
             ... = tt      : H)
        ff_ne_tt)
    (assume H1 : a = tt, H1)

  theorem band_elim_right {a b : bool} (H : a && b = tt) : b = tt :=
  band_elim_left (!band.comm ⬝ H)

  theorem bnot_bnot (a : bool) : bnot (bnot a) = a :=
  bool.cases_on a rfl rfl

  theorem bnot_false : bnot ff = tt :=
  rfl

  theorem bnot_true  : bnot tt = ff :=
  rfl

end bool

open bool

protected definition bool.is_inhabited [instance] : inhabited bool :=
inhabited.mk ff

protected definition bool.has_decidable_eq [instance] : decidable_eq bool :=
take a b : bool,
  bool.rec_on a
    (bool.rec_on b (inl rfl) (inr ff_ne_tt))
    (bool.rec_on b (inr (ne.symm ff_ne_tt)) (inl rfl))
