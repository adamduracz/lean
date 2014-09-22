/*
Copyright (c) 2013-2014 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Author: Leonardo de Moura
*/
#include "library/tactic/proof_state.h"
#include "library/tactic/expr_to_tactic.h"

namespace lean {
void initialize_tactic_module() {
    initialize_proof_state();
    initialize_expr_to_tactic();
}

void finalize_tactic_module() {
    finalize_expr_to_tactic();
    finalize_proof_state();
}
}