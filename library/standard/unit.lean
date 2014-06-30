-- Copyright (c) 2014 Microsoft Corporation. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Author: Leonardo de Moura
import logic

inductive unit : Type :=
| tt : unit

theorem inhabited_unit : inhabited unit
:= inhabited_intro tt